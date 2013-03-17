
#include <SoftwareSerial.h>
#include <Bluetooth.h>
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <SingleInvertedFullState.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>
#include <RcControl.h>

SingleInvertedFullState dz1;

void setup() 
{ 
  delay(100);
  Serial.begin(9600);
  Serial.println("Reset");
  startDataLogging();
  setupBlueToothConnection();
  SetControlLoop( &dz1 );
}

void loop()
{
  RcControl(&blueToothSerial);
  RcControl(&Serial);
}
