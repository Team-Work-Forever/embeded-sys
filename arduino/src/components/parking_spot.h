#pragma once
#include "rgb_led.h"
#include "pressure_sensor.h"
#include <Arduino.h>

enum class SpotState
{
    Free,
    Reserved,
    Occupied,
    Emergency
};

class ParkingSpot
{
private:
    RgbLed led;
    PressureSensor sensor;
    SpotState currentState = SpotState::Free;

    unsigned long reservedStartTime = 0;
    bool wasOccupiedDuringReserve = false;
    const unsigned long reserveTimeout = 120000;

    bool reservedUsed = false;
    bool reservedExpired = false;
    unsigned long specialStateTime = 0;
    const unsigned long specialDisplayDuration = 3000;

public:
    ParkingSpot(int r, int g, int b, int sensorPin)
        : led(r, g, b), sensor(sensorPin) {}

    void init()
    {
        led.init();
        sensor.init();
    }

    void update()
    {
        if (currentState == SpotState::Reserved)
        {
            if (sensor.isPressed())
            {
                wasOccupiedDuringReserve = true;
                led.occupied();
            }
            else if (wasOccupiedDuringReserve)
            {
                reservedUsed = true;
                specialStateTime = millis();
                setState(SpotState::Free);
            }
            else if (millis() - reservedStartTime > reserveTimeout)
            {
                reservedExpired = true;
                specialStateTime = millis();
                setState(SpotState::Free);
            }
            else
            {
                led.reserved();
            }
            return;
        }

        if (currentState == SpotState::Emergency)
        {
            led.emergency();
            return;
        }

        if (sensor.isPressed())
        {
            currentState = SpotState::Occupied;
            led.occupied();
        }
        else
        {
            currentState = SpotState::Free;
            led.free();
        }
    }

    void setState(SpotState state)
    {
        currentState = state;

        if (state == SpotState::Reserved)
        {
            reservedStartTime = millis();
            wasOccupiedDuringReserve = false;
            reservedUsed = false;
            reservedExpired = false;
        }

        if (state == SpotState::Free)
        {
            led.free();
        }
        else if (state == SpotState::Reserved)
        {
            led.reserved();
        }
        else if (state == SpotState::Occupied)
        {
            led.occupied();
        }
        else if (state == SpotState::Emergency)
        {
            led.emergency();
        }
    }

    String getState()
    {
        if (reservedUsed && millis() - specialStateTime < specialDisplayDuration)
        {
            return "free:used";
        }
        if (reservedExpired && millis() - specialStateTime < specialDisplayDuration)
        {
            return "free:expired";
        }

        reservedUsed = false;
        reservedExpired = false;

        switch (currentState)
        {
        case SpotState::Free:
            return "free";
        case SpotState::Reserved:
            return "reserved";
        case SpotState::Occupied:
            return "occupied";
        case SpotState::Emergency:
            return "emergency";
        default:
            return "unknown";
        }
    }
};
