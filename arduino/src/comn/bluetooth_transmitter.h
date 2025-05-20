#pragma once
#include <Arduino.h>
#include <SoftwareSerial.h>

class BluetoothTransmitter
{
private:
    Stream &out;

public:
    BluetoothTransmitter(Stream &outputStream) : out(outputStream) {}

    void send(const String &message)
    {
        out.println(message);
    }
};
