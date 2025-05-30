#pragma once
#include <DHT.h>
#include <Arduino.h>

class TempSensor
{
private:
    int dataPin;
    DHT dht;
    unsigned long lastReadTime = 0;
    const unsigned long interval = 5000;
    float lastTemp = NAN;
    float lastHum = NAN;

public:
    TempSensor(int pin)
        : dataPin(pin), dht(pin, DHT11) {}

    void init()
    {
        dht.begin();
    }

    void update()
    {
        unsigned long now = millis();
        if (now - lastReadTime >= interval)
        {
            float t = dht.readTemperature();
            float h = dht.readHumidity();

            if (!isnan(t))
                lastTemp = t;
            if (!isnan(h))
                lastHum = h;

            lastReadTime = now;
        }
    }

    float getTemperature() const
    {
        return lastTemp;
    }

    float getHumidity() const
    {
        return lastHum;
    }

    bool isTooHot(float threshold = 24.0) const
    {
        return !isnan(lastTemp) && lastTemp > threshold;
    }
};
