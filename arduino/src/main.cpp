#include <Arduino.h>
#include <SoftwareSerial.h>
#include "logic/park_manager.h"
#include "logic/bluetoothCommandHandler.h"

TempSensor tempSensor(7);
ParkingSpot spots[] = {
    ParkingSpot(9, 10, 11, A0),
    ParkingSpot(2, 4, 8, A1),
    ParkingSpot(3, 5, 6, A2),
};
int numSpots = sizeof(spots) / sizeof(spots[0]);

SoftwareSerial BT(12, 13);
BluetoothTransmitter bt(BT);
ParkManager manager(tempSensor, spots, numSpots);

void setup()
{
  BT.begin(9600);
  Serial.begin(9600);
  manager.init();
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
    BluetoothCommandHandler::handle(command, manager, BT);
  }

  manager.update();
  delay(20);
}