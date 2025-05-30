#include <Arduino.h>
#include <SoftwareSerial.h>
#include "logic/bluetoothCommandHandler.h"
#include "components/infra_red.h"
#include "components/buzzer.h"
#include "./comn/bluetooth_transmitter.h"
// #include <LiquidCrystal.h>

SoftwareSerial BT(2, 3);
BluetoothTransmitter bt(BT);

#define INFRA_RED_IN_PIN A0
#define INFRA_RED_OUT_PIN A1
#define BUZZER_PIN 8

InfraRed infraRedIn(INFRA_RED_IN_PIN);
InfraRed infraRedOut(INFRA_RED_OUT_PIN);
Buzzer buzzer(BUZZER_PIN);
// LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
int numCars = 0;

void setup()
{
  Serial.begin(9600);

  infraRedIn.init();
  infraRedOut.init();
  buzzer.init();

  // lcd.begin(16, 2);
  // lcd.setCursor(0, 0);
  // lcd.print("Cars: 0   ");

  BT.begin(9600);
  BT.println("Bluetooth ready. Send commands.");
}

void loop()
{
  // bool inDetected = infraRedIn.isDetected();
  // if (inDetected && !lastInDetected)
  // {
  //   BT.println("CAR IN");
  // }
  // lastInDetected = inDetected;

  // bool outDetected = infraRedOut.isDetected();
  // if (outDetected && !lastOutDetected)
  // {
  //   BT.println("CAR OUT");
  // }
  // lastOutDetected = outDetected;

  if (BT.available())
  {
    String command = BT.readStringUntil('\n');
    command.trim();
    if (command.startsWith("SET CAPACITY"))
    {
      int value = command.substring(13).toInt();
      // numCars = value;
      // lcd.setCursor(0, 0);
      // lcd.print("Cars: ");
      // lcd.print(numCars);
      // lcd.print("   ");
    }
    else
    {
      BluetoothCommandHandler::handle(command, BT, infraRedIn, infraRedOut, buzzer);
    }
  }
  delay(150);
}
