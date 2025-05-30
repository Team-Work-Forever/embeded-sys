#pragma once
#include <Arduino.h>

class InfraRed
{
private:
    int pin;

public:
    InfraRed(int p) : pin(p) {}
    void init() { pinMode(pin, INPUT); }
    bool isDetected(int threshold = 100) const
    {
        return analogRead(pin) > threshold;
    }
};