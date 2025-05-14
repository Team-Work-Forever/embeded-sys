#pragma once
#include "temperature_sensor.h"
#include "parking_spot.h"
#include "bluetooth_transmitter.h"

class ParkManager
{
private:
    TempSensor temp;
    ParkingSpot spot1;
    ParkingSpot spot2;
    BluetoothTransmitter bt;

public:
    ParkManager(TempSensor t, ParkingSpot s1, ParkingSpot s2, BluetoothTransmitter b)
        : temp(t), spot1(s1), spot2(s2), bt(b) {}

    void init()
    {
        temp.init();
        spot1.init();
        spot2.init();
    }

    void update()
    {
        temp.update();

        String state = temp.isTooHot(24.0) ? "FIRE" : "NORMAL";
        String s1 = spot1.getState();
        String s2 = spot2.getState();

        bt.sendState(state, s1, s2);

        if (state == "FIRE")
        {
            spot1.emergency();
            spot2.emergency();
        }
        else
        {
            spot1.update();
            spot2.update();
        }
    }
};
