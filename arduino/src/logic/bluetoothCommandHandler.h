#pragma once
#include "park_manager.h"

class BluetoothCommandHandler
{
public:
    static void handle(const String &command, ParkManager &manager, Stream &bt)
    {
        String cmd = command;
        cmd.trim();

        if (cmd.startsWith("SET"))
        {
            int index = cmd.substring(4, 5).toInt() - 1;
            String state = cmd.substring(6);
            manager.setSpotState(index, state);
            bt.println("Spot " + String(index + 1) + " set to " + state);
        }
        else if (cmd == "GET STATUS")
        {
            bt.println(manager.getStatus());
        }
        else if (cmd == "WHOAREYOU")
        {
            bt.println("PARKSET");
        }
        else
        {
            bt.println("Unknown command.");
        }
    }
};
