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
        int sum = 0;
        for (int i = 0; i < 5; i++)
        {
            sum += analogRead(signalPin);
            delay(2);
        }
        return sum / 5;
    }

    bool isPressed(int threshold = 100) const
    {
        return read() > threshold;
    }
};
