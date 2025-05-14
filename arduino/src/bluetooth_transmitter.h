#pragma once
#include <Arduino.h>

class BluetoothTransmitter
{
public:
    void sendState(const String parkState, const String s1, const String s2)
    {
        Serial.println(parkState + ";" + s1 + ";" + s2);
    }
};
