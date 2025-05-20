#include <Arduino.h>
#include <SoftwareSerial.h>
#include "logic/park_manager.h"
#include "logic/bluetoothCommandHandler.h"

#define SET_BT_NAME false

TempSensor tempSensor(7);
ParkingSpot spots[] = {
    ParkingSpot(9, 10, 11, A0),
    ParkingSpot(2, 4, 8, A1),
    ParkingSpot(3, 5, 6, A2),
};
int numSpots = sizeof(spots) / sizeof(spots[0]);

SoftwareSerial BT(12, 13);
BluetoothTransmitter bt(BT);
ParkManager manager(tempSensor, spots, numSpots, bt);

void setup()
{
  Serial.begin(9600);
  manager.init();

  if (SET_BT_NAME)
  {
    BT.begin(38400);
    delay(500);
    BT.println("AT+NAME=LOT");
  }
  else
  {
    BT.begin(9600);
    BT.println("Bluetooth ready. Send commands.");
  }
}

void loop()
{
  manager.update();
  
  if (BT.available())
  {
    String command = BT.readStringUntil('\n');
    BluetoothCommandHandler::handle(command, manager, BT);
  }
  
  delay(150);
}
