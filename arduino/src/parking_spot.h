#pragma once
#include "rgb_led.h"
#include "pressure_sensor.h"
#include <Arduino.h>

class ParkingSpot
{
private:
    RgbLed led;
    PressureSensor sensor;

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
        if (sensor.isPressed())
        {
            led.occupied();
        }
        else
        {
            led.free();
        }
    }

    void emergency()
    {
        led.emergency();
    }

    void reserved()
    {
        led.reserved();
    }

    void off()
    {
        led.off();
    }

    String getState() const
    {
        return sensor.isPressed() ? "occupied" : "free";
    }
};
