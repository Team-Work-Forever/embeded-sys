#pragma once
#include "park_manager.h"

class BluetoothCommandHandler
{
public:
    static void handle(const String &command, ParkManager &manager, Stream &bt)
    {
        String cmd = command;
        cmd.trim();

        String upperCmd = cmd;
        upperCmd.toUpperCase();

        if (cmd.startsWith("SET"))
        {
            int index = cmd.substring(4, 5).toInt() - 1;
            String state = cmd.substring(6);
            if (state.startsWith("RESERVED "))
            {
                unsigned long timestamp = strtoul(state.substring(9).c_str(), NULL, 10);
                manager.setSpotReserved(index, timestamp);
                Serial.print("Timestamp for reservation: ");
                Serial.println(timestamp);
            }
            else
            {
                manager.setSpotState(index, state);
            }

            bt.println("SET OK");
            Serial.print("****** Setting spot ******");
        }
        else if (upperCmd == "GET STATUS")
        {
            bt.println(manager.getStatus());
        }
        else if (upperCmd == "PING")
        {
            Serial.println("Sending PONG response");
            bt.println("PONG");
        }
        else if (upperCmd == "WHOAREYOU")
        {
            Serial.println("Sending PARKSET response");
            bt.println("PARKSET");
        }
        else if (upperCmd == "MAC")
        {
            Serial.println("Sending MAC response");
            bt.println("98:D3:B1:FE:9A:EE");
        }
        else
        {
            bt.println("Unknown command.");
        }
    }
};
