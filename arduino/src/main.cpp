#include <Arduino.h>
#include "park_manager.h"

TempSensor tempSensor(7);
ParkingSpot spot1(9, 10, 11, A0);
ParkingSpot spot2(3, 5, 6, A1);
BluetoothTransmitter bt;
ParkManager manager(tempSensor, spot1, spot2, bt);

void setup()
{
  Serial.begin(9600);
  manager.init();
}

void loop()
{
  manager.update();
  delay(150);
}
