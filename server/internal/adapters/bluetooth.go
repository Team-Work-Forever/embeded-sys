package adapters

import (
	"errors"
	"fmt"
	"log"
	"server/internal/domain"
	"server/internal/repositories"
	"strings"
	"sync"
	"time"

	"gorm.io/gorm"
	"tinygo.org/x/bluetooth"

	goSerial "go.bug.st/serial"
)

type (
	BluetoothServer struct {
		deviceStore domain.DeviceStore
		parkSetRepo repositories.IParkSetRepository
		Service     ReservationFinalizer
	}

	BluetoothConnection struct {
		MAC        string
		Port       goSerial.Port
		DevPath    string
		Device     *domain.ParkSet
		DeviceType string
		mux        sync.Mutex
	}
)

type ReservationFinalizer interface {
	FinalizeReservationBySlotId(slotId string)
	CancelReservationBySlotId(slotId string)
}

var (
	BluetoothDevices = bluetoothDevices
	bluetoothDevices = make(map[string]*BluetoothConnection)
	devicesMux       sync.RWMutex
)

func NewBluetoothServer(deviceStore domain.DeviceStore, parkSetRepo repositories.IParkSetRepository, service ReservationFinalizer) *BluetoothServer {
	return &BluetoothServer{
		deviceStore: deviceStore,
		parkSetRepo: parkSetRepo,
		Service:     service,
	}
}

func getMACFromNearby(devPath string) (string, error) {
	adapter := bluetooth.DefaultAdapter
	if err := adapter.Enable(); err != nil {
		return "", fmt.Errorf("error activating Bluetooth adapter: %w", err)
	}

	macChan := make(chan string, 1)

	go func() {
		adapter.Scan(func(adapter *bluetooth.Adapter, result bluetooth.ScanResult) {
			if strings.Contains(strings.ToLower(devPath), "rfcomm") {
				log.Printf("Device found via scan: %s [%s]", result.Address.String(), result.LocalName())
				macChan <- result.Address.String()
				_ = adapter.StopScan()
			}
		})
	}()

	select {
	case mac := <-macChan:
		return mac, nil
	case <-time.After(10 * time.Second):
		_ = adapter.StopScan()
		return "", fmt.Errorf("timeout when trying to detect MAC for %s", devPath)
	}
}

func SendAndReadLine(mac string, message string, timeout time.Duration) (string, error) {
	const maxRetries = 3
	devicesMux.RLock()
	conn, ok := bluetoothDevices[mac]
	devicesMux.RUnlock()
	if !ok {
		return "", fmt.Errorf("device %s not connected", mac)
	}
	conn.mux.Lock()
	defer conn.mux.Unlock()
	log.Printf("Attempt 1: Sending command to %s: %s", mac, message)
	_, err := conn.Port.Write([]byte(message + "\n"))
	if err != nil {
		return "", fmt.Errorf("error when writing to %s: %v", mac, err)
	}
	conn.Port.SetReadTimeout(timeout)
	var result []byte
	buf := make([]byte, 1)
	start := time.Now()
	for {
		n, err := conn.Port.Read(buf)
		if err != nil || n == 0 {
			if time.Since(start) > timeout {
				log.Printf("Timeout for %s: partial response [%s]", mac, string(result))
				break
			}
			continue
		}
		result = append(result, buf[:n]...)
		if buf[0] == '\n' {
			response := strings.TrimSpace(string(result))
			log.Printf("Complete answer from %s: %s", mac, response)
			return response, nil
		}
	}
	return "", fmt.Errorf("timeout waiting for response from Arduino after %d attempts", maxRetries)
}

func getDeviceStatusWithRaw(mac string) (domain.ParkState, []domain.ParkLotState, []string, error) {
	resp, err := SendAndReadLine(mac, "GET STATUS", 1*time.Second)
	if err != nil {
		return 0, nil, nil, fmt.Errorf("error sending GET STATUS command: %v", err)
	}
	return parseStatusResponse(resp)
}

func pingBluetoothDevice(mac string) bool {
	resp, err := SendAndReadLine(mac, "PING", 5*time.Second)
	return err == nil && strings.ToUpper(resp) == "PONG"
}

func (blue *BluetoothServer) connectBluetoothDevice(devPath, macAddr string) {
	devicesMux.Lock()
	if oldConn, ok := bluetoothDevices[macAddr]; ok {
		_ = oldConn.Port.Close()
		delete(bluetoothDevices, macAddr)
	}
	devicesMux.Unlock()

	p, err := goSerial.Open(devPath, &goSerial.Mode{BaudRate: 9600})
	if err != nil {
		log.Printf("Error opening port %s: %v", devPath, err)
		return
	}

	conn := &BluetoothConnection{
		MAC:     macAddr,
		Port:    p,
		DevPath: devPath,
	}
	devicesMux.Lock()
	bluetoothDevices[macAddr] = conn
	devicesMux.Unlock()

	time.Sleep(1 * time.Second)

	if !pingBluetoothDevice(macAddr) {
		log.Printf("Failed to ping device %s after connection", macAddr)
		_ = p.Close()
		devicesMux.Lock()
		delete(bluetoothDevices, macAddr)
		devicesMux.Unlock()
		return
	}

	resp, err := SendAndReadLine(macAddr, "WHOAREYOU", 1*time.Second)
	if err != nil {
		log.Printf("Error sending WHOAREYOU to %s: %v", macAddr, err)
		_ = p.Close()
		devicesMux.Lock()
		delete(bluetoothDevices, macAddr)
		devicesMux.Unlock()
		return
	}

	log.Printf("Response WHOAREYOU from %s: [%s]", macAddr, resp)

	conn.DeviceType = strings.TrimSpace(resp)
	switch conn.DeviceType {
	case "PARKSET":
		blue.initOrLoadParkSet(macAddr)
	case "CONTROL":
		log.Printf("Device CONTROL %s initialised", macAddr)
	default:
		log.Printf("Unknown device type [%s] (%s)", conn.DeviceType, macAddr)
		_ = p.Close()
		devicesMux.Lock()
		delete(bluetoothDevices, macAddr)
		devicesMux.Unlock()
	}
}

func (blue *BluetoothServer) initOrLoadParkSet(mac string) {
	mac = strings.ToUpper(mac)

	devicesMux.RLock()
	conn := bluetoothDevices[mac]
	devicesMux.RUnlock()
	if conn == nil {
		log.Printf("Bluetooth connection missing for MAC %s", mac)
		return
	}

	log.Printf("Checking if MAC %s already exists in the repository...", mac)
	parkSet, err := blue.parkSetRepo.GetByMAC(mac)

	parkSetState, lotStates, _, err := getDeviceStatusWithRaw(mac)
	if err != nil {
		log.Printf("Error obtaining ParkSet status %s: %v", mac, err)
		return
	}

	if err == nil && parkSet != nil {
		if parkSet.DeletedAt.Valid {
			parkSet.DeletedAt = &gorm.DeletedAt{}
			log.Printf("ParkSet %s reactivated", mac)
		}
		parkSet.State = parkSetState
		parkSet.Lots = nil
		for i, lotState := range lotStates {
			lot := domain.NewParkLot(lotState, uint32(i+1), 1)
			parkSet.AddLot(lot)
		}
		if err := blue.parkSetRepo.Update(parkSet); err != nil {
			log.Printf("Error updating ParkSet %s: %v", mac, err)
			return
		}
		conn.Device = parkSet
		log.Printf("Device %s associated with MAC %s (reactivated and synchronised)", mac, mac)
		return
	}

	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		log.Printf("Unexpected error when searching for ParkSet by MAC %s: %v", mac, err)
		return
	}

	parkSet = domain.NewParkSet(parkSetState)
	parkSet.MAC = mac

	for i, lotState := range lotStates {
		lot := domain.NewParkLot(lotState, uint32(i+1), 1)
		parkSet.AddLot(lot)
	}

	if err := blue.parkSetRepo.Create(parkSet); err != nil {
		log.Printf("Error creating new ParkSet for MAC %s: %v", mac, err)
		return
	}

	blue.deviceStore.AddDevice(parkSet)
	conn.Device = parkSet
	log.Printf("Device %s associated with MAC %s (new)", mac, mac)
}

func (blue *BluetoothServer) UpdateParkSet() {
	devicesMux.RLock()
	defer devicesMux.RUnlock()
	for mac, conn := range bluetoothDevices {
		if conn.DeviceType != "PARKSET" || conn.Device == nil {
			continue
		}
		parkSetState, lotStates, rawStates, err := getDeviceStatusWithRaw(mac)
		if err != nil {
			log.Printf("Error obtaining device status %s: %v", mac, err)
			continue
		}
		conn.Device.State = parkSetState

		if parkSetState == domain.Fire {
			log.Printf("Set %s to FIRE status, cancelling all reservations", mac)
			for i, lot := range conn.Device.Lots {
				blue.Service.CancelReservationBySlotId(lot.PublicId)
				if err := blue.ChangeParkLotState(mac, i+1, domain.Free); err != nil {
					log.Printf("Error setting slot %d to FREE in %s: %v", i+1, mac, err)
					continue
				}
				lot.State = domain.Free
				blue.parkSetRepo.UpdateLotState(lot.PublicId, domain.Free)
			}
		} else {
			for i, lotState := range lotStates {
				if i >= len(conn.Device.Lots) {
					continue
				}
				raw := strings.ToLower(rawStates[i])
				base := strings.SplitN(raw, ":", 2)[0]
				suffix := ""
				if strings.Contains(raw, ":") {
					suffix = strings.SplitN(raw, ":", 2)[1]
				}
				conn.Device.Lots[i].State = lotState
				if base == "free" {
					switch suffix {
					case "used":
						blue.Service.FinalizeReservationBySlotId(conn.Device.Lots[i].PublicId)
					case "expired":
						blue.Service.CancelReservationBySlotId(conn.Device.Lots[i].PublicId)
					}
					blue.parkSetRepo.UpdateLotState(conn.Device.Lots[i].PublicId, domain.Free)
				}
				if base == "occupied" || base == "reserved" {
					blue.parkSetRepo.UpdateLotState(conn.Device.Lots[i].PublicId, lotState)
				}
			}
		}
		if err := blue.parkSetRepo.Update(conn.Device); err != nil {
			log.Printf("Error updating ParkSet %s: %v", mac, err)
		}
	}
}

func (blue *BluetoothServer) cleanupDisconnectedDevices(found map[string]bool) {
	var toDisconnect []string
	devicesMux.RLock()
	for mac := range bluetoothDevices {
		if !found[mac] && !pingBluetoothDevice(mac) {
			log.Printf("Device %s did not respond to ping, will be disconnected", mac)
			toDisconnect = append(toDisconnect, mac)
		}
	}
	devicesMux.RUnlock()

	for _, mac := range toDisconnect {
		devicesMux.Lock()
		conn := bluetoothDevices[mac]
		if conn.DeviceType == "PARKSET" && conn.Device != nil {
			now := time.Now()
			conn.Device.DeletedAt = &gorm.DeletedAt{Time: now, Valid: true}
			if err := blue.parkSetRepo.Update(conn.Device); err != nil {
				log.Printf("Error marking ParkSet %s as deleted: %v", mac, err)
			} else {
				log.Printf("ParkSet %s marked as deleted in the database", mac)
			}
			blue.deviceStore.RemoveDevice(mac)
			log.Printf("ParkSet %s removed from memory store", mac)
		}
		if conn.Port != nil {
			_ = conn.Port.Close()
		}
		delete(bluetoothDevices, mac)
		devicesMux.Unlock()
	}
}

func (blue *BluetoothServer) UpdateControlDevices() {
	devicesMux.RLock()
	defer devicesMux.RUnlock()
	for mac, conn := range bluetoothDevices {
		if conn.DeviceType != "CONTROL" {
			continue
		}
		resp, err := SendAndReadLine(mac, "BUZZER_OFF", 1*time.Second)
		if err != nil {
			log.Printf("Error sending BUZZER_OFF to %s: %v", mac, err)
			continue
		}
		log.Printf("Device CONTROL %s responded: %s", mac, resp)
	}
}

func (blue *BluetoothServer) ChangeParkLotState(mac string, lotNumber int, state domain.ParkLotState) error {
	cmd := fmt.Sprintf("SET %d %v", lotNumber, domain.GetParkLotState(state))
	resp, err := SendAndReadLine(mac, cmd, 1*time.Second)
	log.Printf("Sending SET command to %s: %s, response: %s", mac, cmd, resp)
	if err != nil {
		return fmt.Errorf("Error sending SET command: %v", err)
	}
	if resp != "SET OK" {
		log.Printf("Unexpected response when setting status of vacancy %d in %s: %s", lotNumber, mac, resp)
		return fmt.Errorf("Failure to set status of vacancy %d in %s: %s", lotNumber, mac, resp)
	}
	_, lotStates, _, err := getDeviceStatusWithRaw(mac)
	if err != nil {
		log.Printf("Error validating status after SET to %s: %v", mac, err)
		return fmt.Errorf("Error validating status after SET: %v", err)
	}
	if lotNumber-1 < len(lotStates) && lotStates[lotNumber-1] != state {
		log.Printf("Status of vacancy %d in %s does not match expectations (%v != %v)", lotNumber, mac, lotStates[lotNumber-1], state)
		return fmt.Errorf("vacancy status %d not updated correctly", lotNumber)
	}
	log.Printf("Status of vacancy %d in %s successfully validated: %v", lotNumber, mac, state)
	return nil
}

func (blue *BluetoothServer) Serve() error {
	for {
		found := blue.detectAndConnectBluetoothPorts()
		blue.cleanupDisconnectedDevices(found)
		blue.UpdateParkSet()
		blue.UpdateControlDevices()
		time.Sleep(2 * time.Second)
	}
}

func (blue *BluetoothServer) detectAndConnectBluetoothPorts() map[string]bool {
	devEntries, err := goSerial.GetPortsList()
	if err != nil {
		log.Printf("Error listing serial ports: %v", err)
		return nil
	}

	found := make(map[string]bool)

	for _, devPath := range devEntries {
		if !strings.Contains(devPath, "rfcomm") {
			continue
		}

		devicesMux.RLock()
		isAlreadyUsed := false
		for _, conn := range bluetoothDevices {
			if conn.DevPath == devPath {
				isAlreadyUsed = true
				break
			}
		}
		devicesMux.RUnlock()
		if isAlreadyUsed {
			continue
		}

		macAddr, err := getMACFromNearby(devPath)
		if err != nil {
			log.Printf("Error obtaining MAC from %s: %v", devPath, err)
			continue
		}

		devicesMux.RLock()
		if conn, exists := bluetoothDevices[macAddr]; exists && conn.Port != nil {
			log.Printf("MAC %s is already connected via %s, ignoring new port %s", macAddr, conn.DevPath, devPath)
			devicesMux.RUnlock()
			continue
		}
		devicesMux.RUnlock()

		blue.connectBluetoothDevice(devPath, macAddr)
		found[macAddr] = true
	}

	return found
}

func parseStatusResponse(resp string) (domain.ParkState, []domain.ParkLotState, []string, error) {
	resp = strings.TrimSpace(resp)
	if resp == "" {
		return 0, nil, nil, fmt.Errorf("empty response")
	}
	parts := strings.Split(resp, ";")
	log.Printf("Raw response: %s", resp)

	if len(parts) < 2 {
		return 0, nil, nil, fmt.Errorf("invalid answer: %s", resp)
	}

	var parkSetState domain.ParkState
	switch strings.ToUpper(parts[0]) {
	case "FIRE":
		parkSetState = domain.Fire
	case "NORMAL":
		parkSetState = domain.Normal
	default:
		return 0, nil, nil, fmt.Errorf("unknown status: %s", parts[0])
	}

	var lotStates []domain.ParkLotState
	var rawStates []string

	for _, s := range parts[1:] {
		s = strings.TrimSpace(s)
		if s == "" {
			return 0, nil, nil, fmt.Errorf("empty slot status")
		}
		rawStates = append(rawStates, s)

		base := strings.ToUpper(strings.SplitN(s, ":", 2)[0])
		switch base {
		case "FREE":
			lotStates = append(lotStates, domain.Free)
		case "OCCUPIED":
			lotStates = append(lotStates, domain.Occupied)
		case "RESERVED":
			lotStates = append(lotStates, domain.Reserved)
		default:
			return 0, nil, nil, fmt.Errorf("slot status unknown: %s", s)
		}
	}

	return parkSetState, lotStates, rawStates, nil
}
