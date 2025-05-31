package adapters

import (
	"fmt"
	"log"
	"os"
	"server/internal/domain"
	"server/internal/repositories"
	"server/internal/services"
	"strings"
	"time"

	goSerial "go.bug.st/serial"
	"go.bug.st/serial/enumerator"
)

type (
	BluetoothServer struct {
		deviceStore domain.DeviceStore
		parkSetRepo repositories.IParkSetRepository
		service     *services.ParkSenseServiceImpl
	}
)

func NewBluetoothServer(deviceStore domain.DeviceStore, parkSetRepo repositories.IParkSetRepository, service *services.ParkSenseServiceImpl) *BluetoothServer {
	return &BluetoothServer{
		deviceStore: deviceStore,
		parkSetRepo: parkSetRepo,
		service:     service,
	}
}

var (
	bluetoothPorts = make(map[string]goSerial.Port)
	portToParkSet  = make(map[string]*domain.ParkSet)
	deviceTypes    = make(map[string]string)
)

func ConnectDevices() {
	envPort := os.Getenv("DEVICE_PORT")
	if envPort != "" {
		log.Printf("Bluetooth port user manual: %s", envPort)
		ConnectDeviceById(envPort)
		return
	}
	ports, err := enumerator.GetDetailedPortsList()
	if err != nil {
		log.Printf("Error listing ports: %v", err)
		return
	}
	for _, port := range ports {
		if port.IsUSB && (port.Product == "HC-05" || strings.Contains(strings.ToUpper(port.Product), "HC-05")) {
			p, err := goSerial.Open(port.Name, &goSerial.Mode{BaudRate: 9600})
			if err != nil {
				log.Printf("Error when opening %s: %v", port.Name, err)
				continue
			}
			bluetoothPorts[port.Name] = p
			log.Printf("Connected to HC-05 on the port %s", port.Name)
		}
	}
}

func ConnectDeviceById(id string) {
	p, err := goSerial.Open(id, &goSerial.Mode{BaudRate: 9600})
	if err != nil {
		log.Printf("Error when opening %s: %v", id, err)
		return
	}
	bluetoothPorts[id] = p
	log.Printf("Connected to HC-05 on the port %s", id)
}

func DisconnectDevice(id string) {
	if port, ok := bluetoothPorts[id]; ok {
		_ = port.Close()
		delete(bluetoothPorts, id)
		log.Printf("Disconnected HC-05 from the port %s", id)
	}
}

func SendBluetoothMessage(id string, message string) error {
	port, ok := bluetoothPorts[id]
	if !ok {
		return fmt.Errorf("port %s not connected", id)
	}
	_, err := port.Write([]byte(message + "\r\n"))
	return err
}

func ReadBluetoothResponse(id string) (string, error) {
	port, ok := bluetoothPorts[id]
	if !ok {
		return "", fmt.Errorf("port %s not connected", id)
	}
	buf := make([]byte, 128)
	n, err := port.Read(buf)
	if err != nil {
		return "", err
	}
	return string(buf[:n]), nil
}

func parseStatusResponse(resp string) (domain.ParkState, []domain.ParkLotState, []string, error) {
	parts := strings.Split(resp, ";")
	if len(parts) < 2 {
		return 0, nil, nil, fmt.Errorf("invalid answer: %s", resp)
	}

	var parkSetState domain.ParkState
	switch parts[0] {
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
		rawStates = append(rawStates, s)

		base := strings.ToUpper(strings.SplitN(s, ":", 2)[0])

		switch base {
		case "FREE":
			lotStates = append(lotStates, domain.Free)
		case "OCCUPIED":
			lotStates = append(lotStates, domain.Occupied)
		case "RESERVED":
			lotStates = append(lotStates, domain.Reserved)
		case "":
		default:
			return 0, nil, nil, fmt.Errorf("slot status unknown: %s", s)
		}
	}

	return parkSetState, lotStates, rawStates, nil
}

func getDeviceStatusWithRaw(portName string) (domain.ParkState, []domain.ParkLotState, []string, error) {
	err := SendBluetoothMessage(portName, "GET STATUS")
	if err != nil {
		return 0, nil, nil, fmt.Errorf("error sending GET STATUS to %s: %v", portName, err)
	}
	resp, err := ReadBluetoothResponse(portName)
	if err != nil {
		return 0, nil, nil, fmt.Errorf("error reading device response %s: %v", portName, err)
	}
	return parseStatusResponse(resp)
}

func (blue *BluetoothServer) CreateParkSet() {
	for portName := range bluetoothPorts {
		if _, exists := portToParkSet[portName]; exists {
			continue
		}
		parkSetState, lotStates, _, err := getDeviceStatusWithRaw(portName)
		if err != nil {
			log.Printf("Error obtaining device status %s: %v", portName, err)
			continue
		}
		parkSet := domain.NewParkSet(parkSetState)
		for i, lotState := range lotStates {
			lot := domain.NewParkLot(lotState, uint32(i+1), 1)
			parkSet.AddLot(lot)
		}
		blue.deviceStore.AddDevice(parkSet)
		if err := blue.parkSetRepo.Create(parkSet); err != nil {
			log.Printf("Error creating ParkSet: %v", err)
		}
		portToParkSet[portName] = parkSet
	}
}

func (blue *BluetoothServer) UpdateParkSet() {
	for portName, parkSet := range portToParkSet {
		parkSetState, lotStates, rawStates, err := getDeviceStatusWithRaw(portName)
		if err != nil {
			log.Printf("Error obtaining device status %s: %v", portName, err)
			continue
		}

		parkSet.State = parkSetState

		for i, lotState := range lotStates {
			if i >= len(parkSet.Lots) {
				continue
			}

			raw := strings.ToLower(rawStates[i])
			base := strings.SplitN(raw, ":", 2)[0]
			suffix := ""
			if strings.Contains(raw, ":") {
				suffix = strings.SplitN(raw, ":", 2)[1]
			}

			parkSet.Lots[i].State = lotState

			if base == "free" {
				switch suffix {
				case "used":
					blue.service.FinalizeReservationBySlotId(parkSet.Lots[i].PublicId)
				case "expired":
					blue.service.CancelReservationBySlotId(parkSet.Lots[i].PublicId)
				}

			}
		}

		if err := blue.parkSetRepo.Update(parkSet); err != nil {
			log.Printf("Error updating ParkSet: %v", err)
		}
	}
}

func (blue *BluetoothServer) ChangeParkLotState(deviceID string, lotNumber int, state domain.ParkLotState) error {
	cmd := fmt.Sprintf("SET %d %v", lotNumber, state)
	return SendBluetoothMessage(deviceID, cmd)
}

func (blue *BluetoothServer) GetParkSetStatus(deviceID string) (string, error) {
	err := SendBluetoothMessage(deviceID, "GET STATUS")
	if err != nil {
		return "", err
	}
	return ReadBluetoothResponse(deviceID)
}

func SendCommandToDevice(deviceType string, command string) error {
	for port, typ := range deviceTypes {
		if typ == deviceType {
			return SendBluetoothMessage(port, command)
		}
	}
	return fmt.Errorf("No device of type %s found", deviceType)
}

func (blue *BluetoothServer) MonitorBluetoothDevices() {
	for {
		ports, err := enumerator.GetDetailedPortsList()
		if err != nil {
			log.Printf("Error listing ports: %v", err)
			time.Sleep(5 * time.Second)
			continue
		}

		found := make(map[string]bool)

		for _, port := range ports {
			if strings.Contains(strings.ToUpper(port.Product), "HC-05") ||
				strings.Contains(strings.ToUpper(port.Name), "HC-05") ||
				strings.Contains(strings.ToUpper(port.SerialNumber), "HC-05") {
				log.Printf("HC-05 port detected: %s (Product: %s, SerialNumber: %s)", port.Name, port.Product, port.SerialNumber)
				found[port.Name] = true
				if _, ok := bluetoothPorts[port.Name]; !ok {
					p, err := goSerial.Open(port.Name, &goSerial.Mode{BaudRate: 9600})
					if err != nil {
						log.Printf("Error when opening %s: %v", port.Name, err)
						continue
					}
					bluetoothPorts[port.Name] = p
					log.Printf("Connected to the port %s", port.Name)

					err = SendBluetoothMessage(port.Name, "WHOAREYOU")
					if err != nil {
						log.Printf("Error sending WHOAREYOU to %s: %v", port.Name, err)
						continue
					}
					resp, err := ReadBluetoothResponse(port.Name)
					if err != nil {
						log.Printf("Error reading WHOAREYOU response from %s: %v", port.Name, err)
						continue
					}
					deviceType := strings.TrimSpace(resp)
					deviceTypes[port.Name] = deviceType
					if deviceType != "PARKSET" {
						log.Printf("Ignoring non-parkset device: %s (response: %s)", port.Name, resp)
						continue
					}

					if _, exists := portToParkSet[port.Name]; !exists {
						parkSetState, lotStates, _, err := getDeviceStatusWithRaw(port.Name)
						if err != nil {
							log.Printf("Error obtaining device status %s: %v", port.Name, err)
							continue
						}
						parkSet := domain.NewParkSet(parkSetState)
						for i, lotState := range lotStates {
							lot := domain.NewParkLot(lotState, uint32(i+1), 1)
							parkSet.AddLot(lot)
						}
						blue.deviceStore.AddDevice(parkSet)
						if err := blue.parkSetRepo.Create(parkSet); err != nil {
							log.Printf("Error creating ParkSet: %v", err)
						}
						portToParkSet[port.Name] = parkSet
					}
				}
				if parkSet, exists := portToParkSet[port.Name]; exists {
					parkSetState, lotStates, _, err := getDeviceStatusWithRaw(port.Name)
					if err != nil {
						log.Printf("Error obtaining device status %s: %v", port.Name, err)
						continue
					}
					parkSet.State = parkSetState
					for i, lotState := range lotStates {
						if i < len(parkSet.Lots) {
							parkSet.Lots[i].State = lotState
						}
					}
					if err := blue.parkSetRepo.Update(parkSet); err != nil {
						log.Printf("Error updating ParkSet: %v", err)
					}
				}
			}
		}

		for portName, port := range bluetoothPorts {
			if !found[portName] {
				_ = port.Close()
				delete(bluetoothPorts, portName)
				log.Printf("Disconnected HC-05 from the port %s", portName)
				if parkSet, ok := portToParkSet[portName]; ok {
					_ = blue.parkSetRepo.Delete(parkSet)
					delete(portToParkSet, portName)
				}
			}
		}

		time.Sleep(2 * time.Second)
	}
}

func (blue *BluetoothServer) Serve() error {
	go blue.MonitorBluetoothDevices()
	select {}
}

func PortToParkSet() map[string]*domain.ParkSet {
	return portToParkSet
}

func (b *BluetoothServer) SetService(service *services.ParkSenseServiceImpl) {
	b.service = service
}
