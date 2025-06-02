#ifndef DISPLAY_MANAGER_H
#define DISPLAY_MANAGER_H

#include <LiquidCrystal.h>
#include "../logic/car_manager.h"

class DisplayManager
{
private:
    LiquidCrystal lcd;
    CarManager &carManager;
    int lastCarCount;

public:
    DisplayManager(CarManager &cm, int rs, int en, int d4, int d5, int d6, int d7)
        : lcd(rs, en, d4, d5, d6, d7), carManager(cm)
    {
        lastCarCount = -1;
    }

    void init()
    {
        lcd.begin(16, 2);
        updateDisplay();
    }

    void update()
    {
        int currentCount = carManager.getCarCount();
        if (currentCount != lastCarCount)
        {
            updateDisplay();
            lastCarCount = currentCount;
        }
    }

private:
    void updateDisplay()
    {
        lcd.setCursor(0, 0);
        lcd.print("Cars: ");
        lcd.print(carManager.getCarCount());
        lcd.print("   ");
    }
};

#endif