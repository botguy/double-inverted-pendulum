
#include <SoftwareSerial.h>
#include <Bluetooth.h>
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <DoubleInvertedDZ1.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>
#include <RcControl.h>

DoubleInvertedDZ1 dz1;

void setup() 
{ 
  Serial.begin(9600);
  startDataLogging();
  setupBlueToothConnection();
  SetControlLoop( &dz1 );
}

void loop()
{
  RcControl(&blueToothSerial);
 //RcControl(&Serial);
}
