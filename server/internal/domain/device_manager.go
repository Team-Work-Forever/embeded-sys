package domain

import (
	"slices"
	"sync"
)

type (
	DeviceStore interface {
		AddDevice(device *ParkSet)
		RemoveDevice(mac string)
		GetDevices() []*ParkSet
		Subscrive() (<-chan *ParkSet, func())
	}

	DeviceManager struct {
		mux *sync.RWMutex

		devices   map[string]*ParkSet // key is MAC
		listeners []chan *ParkSet
	}
)

func NewDeviceManager() *DeviceManager {
	return &DeviceManager{
		mux:       &sync.RWMutex{},
		devices:   make(map[string]*ParkSet),
		listeners: []chan *ParkSet{},
	}
}

func (dm *DeviceManager) AddDevice(device *ParkSet) {
	dm.mux.Lock()
	defer dm.mux.Unlock()

	dm.devices[device.MAC] = device

	for _, ch := range dm.listeners {
		ch <- device
	}
}

func (dm *DeviceManager) RemoveDevice(mac string) {
	dm.mux.Lock()
	defer dm.mux.Unlock()

	delete(dm.devices, mac)
}

func (dm *DeviceManager) GetDevices() []*ParkSet {
	dm.mux.RLock()
	defer dm.mux.RUnlock()

	getDevices := make([]*ParkSet, 0, len(dm.devices))

	for _, d := range dm.devices {
		getDevices = append(getDevices, d)
	}

	return getDevices
}

func (dm *DeviceManager) Subscrive() (<-chan *ParkSet, func()) {
	ch := make(chan *ParkSet, 5)

	dm.mux.Lock()
	dm.listeners = append(dm.listeners, ch)
	dm.mux.Unlock()

	unsubscribe := func() {
		dm.mux.Lock()
		defer dm.mux.Unlock()

		for i, listener := range dm.listeners {
			if listener == ch {
				dm.listeners = slices.Delete(dm.listeners, i, i+1)
				break
			}
		}
		close(ch)
	}

	return ch, unsubscribe
}
