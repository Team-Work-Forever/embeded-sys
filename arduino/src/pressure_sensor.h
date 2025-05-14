#pragma once
#include <Arduino.h>

class PressureSensor
{
private:
    int signalPin;

public:
    PressureSensor(int pin)
        : signalPin(pin) {}

    void init()
    {
        pinMode(signalPin, INPUT);
    }

    int read() const
    {
        return analogRead(signalPin);
    }

    bool isPressed(int threshold = 100) const
    {
        return read() > threshold;
    }
};
