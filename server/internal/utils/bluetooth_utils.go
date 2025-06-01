package utils

import "server/internal/adapters"

func FindDeviceAndLotNumberBySlotId(slotId string) (string, int) {
	for mac, conn := range adapters.BluetoothDevices {
		if conn.Device == nil {
			continue
		}
		for idx, lot := range conn.Device.Lots {
			if lot.PublicId == slotId {
				return mac, idx + 1
			}
		}
	}
	return "", 0
}
