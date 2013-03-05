#ifndef Bluetooth_h
#define Bluetooth_h

#include <SoftwareSerial.h>

#define RxD 6
#define TxD 7

extern SoftwareSerial blueToothSerial;

void setupBlueToothConnection();

#endif // Bluetooth_h
 