#pragma once
#include "../logic/car_manager.h"
#include "../components/infra_red.h"
#include "../components/buzzer.h"

class BluetoothCommandHandler
{
public:
    static void handle(const String &command, Stream &bt, InfraRed &infraRedIn, InfraRed &infraRedOut, Buzzer &buzzer, CarManager &carManager)
    {
        String cmd = command;
        cmd.trim();

        String upperCmd = cmd;
        upperCmd.toUpperCase();

        if (upperCmd == "BUZZER_ON")
        {
            buzzer.on();
            Serial.println("Sending SET ON response");
            bt.println("SET ON");
        }
        else if (upperCmd == "BUZZER_OFF")
        {
            buzzer.off();
            Serial.println("Sending SET OFF response");
            bt.println("SET OFF");
        }
        else if (upperCmd == "PING")
        {
            Serial.println("Sending PONG response");
            bt.println("PONG");
        }
        else if (upperCmd == "WHOAREYOU")
        {
            Serial.println("Sending CONTROL response");
            bt.println("CONTROL");
        }
        else if (upperCmd == "CAPACITY")
        {
            int capacity = carManager.getCarCount();
            Serial.print("Sending CAPACITY response: ");
            Serial.println(capacity);
            bt.println(capacity);
        }
        else if (upperCmd == "CONTROL")
        {
            Serial.println("Sending CONTROL response");
            bt.println("CONTROL");
        }
        else if (upperCmd == "MAC")
        {
            Serial.println("Sending MAC response");
            bt.println("98:D3:11:FD:71:A7");
        }
        else
        {
            bt.println("Unknown command.");
        }
    }
};
