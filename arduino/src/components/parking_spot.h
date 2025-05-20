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
            led.reserved();
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

        switch (state)
        {
        case SpotState::Free:
            led.free();
            break;
        case SpotState::Reserved:
            led.reserved();
            break;
        case SpotState::Occupied:
            led.occupied();
            break;
        case SpotState::Emergency:
            led.emergency();
            break;
        }
    }

    SpotState getRawState() const
    {
        return currentState;
    }

    String getState() const
    {
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
