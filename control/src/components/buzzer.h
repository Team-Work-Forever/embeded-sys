#pragma once
#include <Arduino.h>

class Buzzer
{
private:
    int pin;

public:
    Buzzer(int p) : pin(p) {}
    void init()
    {
        pinMode(pin, OUTPUT);
        off();
    }
    void on() { digitalWrite(pin, HIGH); }
    void off() { digitalWrite(pin, LOW); }
};