#pragma once
#include "./components/temperature_sensor.h"
#include "./components/parking_spot.h"
#include "./comn/bluetooth_transmitter.h"

#define SET_EMERGENCY_TEMP 30.0

class ParkManager
{
private:
    TempSensor temp;
    ParkingSpot *spots;
    int numSpots;
    String statusMessage = "";

public:
    ParkManager(TempSensor t, ParkingSpot *s, int count)
        : temp(t),
          spots(s), numSpots(count)
    {
    }

    void init()
    {
        temp.init();
        for (int i = 0; i < numSpots; i++)
            spots[i].init();
    }

    void setSpotState(int index, const String &state)
    {
        if (index < 0 || index >= numSpots)
            return;

        if (state == "RESERVED")
            spots[index].setState(SpotState::Reserved);
        else if (state == "FREE")
            spots[index].setState(SpotState::Free);
        else if (state == "OCCUPIED")
            spots[index].setState(SpotState::Occupied);
        else if (state == "EMERGENCY")
            spots[index].setState(SpotState::Emergency);
    }

    void setSpotReserved(int index, unsigned long timestamp)
    {
        if (index < 0 || index >= numSpots)
            return;

        spots[index].setReserved(timestamp);
    }

    void update(bool emergency = false)
    {
        if (emergency)
        {
            for (int i = 0; i < numSpots; i++)
                spots[i].setState(SpotState::Emergency);
            return;
        }

        temp.update();

        String parkState = temp.isTooHot(SET_EMERGENCY_TEMP) ? "FIRE" : "NORMAL";
        statusMessage = parkState;

        for (int i = 0; i < numSpots; i++)
        {
            String state = spots[i].getState();
            statusMessage += ";" + state;

            if (parkState == "FIRE")
            {
                spots[i].setState(SpotState::Emergency);
                continue;
            }
            if (spots[i].getState() == "emergency" && parkState == "NORMAL")
            {
                spots[i].setState(SpotState::Free);
                continue;
            }

            spots[i].update();
        }

        statusMessage = statusMessage;
    }

    String getStatus()
    {
        return statusMessage;
    }
};
