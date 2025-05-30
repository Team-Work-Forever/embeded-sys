#pragma once
#include "park_manager.h"
#include "../components/infra_red.h"
#include "../components/buzzer.h"

class BluetoothCommandHandler
{
public:
    static void handle(const String &command, ParkManager &manager, Stream &bt, InfraRed &infraRedIn, InfraRed &infraRedOut, Buzzer &buzzer)
    {
        String cmd = command;
        cmd.trim();

        if (cmd == "BUZZER_ON")
        {
            buzzer.on();
            bt.println("Buzzer ativado.");
        }
        else if (cmd == "BUZZER_OFF")
        {
            buzzer.off();
            bt.println("Buzzer desativado.");
        }
        else
        {
            bt.println("Unknown command.");
        }
    }
};
