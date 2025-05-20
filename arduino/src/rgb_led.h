#pragma once
#include <Arduino.h>

class RgbLed
{
private:
    int redPin, greenPin, bluePin;

public:
    RgbLed(int r, int g, int b)
        : redPin(r), greenPin(g), bluePin(b) {}

    void init()
    {
        pinMode(redPin, OUTPUT);
        pinMode(greenPin, OUTPUT);
        pinMode(bluePin, OUTPUT);
        off();
    }

    void setColor(bool red, bool green, bool blue)
    {
        digitalWrite(redPin, red ? LOW : HIGH);
        digitalWrite(greenPin, green ? LOW : HIGH);
        digitalWrite(bluePin, blue ? LOW : HIGH);
    }

    void off() { setColor(false, false, false); }
    void emergency() { setColor(true, true, false); }
    void free() { setColor(false, true, false); }
    void reserved() { setColor(false, false, true); }
    void occupied() { setColor(true, false, false); }
};
