#include <Arduino.h>
#include <SoftwareSerial.h>
#include "logic/bluetoothCommandHandler.h"
#include "logic/car_manager.h"
#include "components/infra_red.h"
#include "components/buzzer.h"
#include "components/display.h"
#include "./comn/bluetooth_transmitter.h"

SoftwareSerial BT(2, 3);
BluetoothTransmitter bt(BT);

#define INFRA_RED_IN_PIN A0
#define INFRA_RED_OUT_PIN A1
#define BUZZER_PIN 8

#define LCD_RS_PIN 12
#define LCD_EN_PIN 11
#define LCD_D4_PIN 9
#define LCD_D5_PIN 6
#define LCD_D6_PIN 5
#define LCD_D7_PIN 4

InfraRed infraRedIn(INFRA_RED_IN_PIN);
InfraRed infraRedOut(INFRA_RED_OUT_PIN);
Buzzer buzzer(BUZZER_PIN);
CarManager carManager(infraRedIn, infraRedOut);
DisplayManager displayManager(carManager, LCD_RS_PIN, LCD_EN_PIN, LCD_D4_PIN, LCD_D5_PIN, LCD_D6_PIN, LCD_D7_PIN);

void setup()
{
  BT.begin(9600);
  Serial.begin(9600);

  infraRedIn.init();
  infraRedOut.init();
  buzzer.init();
}

void loop()
{
  if (BT.available())
  {
    String command = BT.readStringUntil('\n');
    command.trim();
    Serial.print("Received command: [");
    Serial.print(command);
    Serial.println("]");
    BluetoothCommandHandler::handle(command, BT, infraRedIn, infraRedOut, buzzer, carManager);
  }

  displayManager.update();
  carManager.update();
  delay(20);
}
