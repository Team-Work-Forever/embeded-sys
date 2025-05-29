package utils

import "server/internal/domain"

func FindDeviceAndLotNumberBySlotId(portToParkSet map[string]*domain.ParkSet, slotId string) (string, int) {
	for deviceID, parkSet := range portToParkSet {
		for idx, lot := range parkSet.Lots {
			if lot.PublicId == slotId {
				return deviceID, idx + 1
			}
		}
	}
	return "", 0
}
