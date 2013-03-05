
#include <SoftwareSerial.h>
#include <Bluetooth.h>
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <SingleInvertedPID.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>


void setup() 
{ 
  Serial.begin(9600);
  startDataLogging();
  setupBlueToothConnection();  
  
  SingleInvertedPID pid;
  SetControlLoop( &pid );
  
  Serial.println("start");
  delay(2000);
  Serial.println("stop");
  stopDataLogging(0);
  printDataLog(&blueToothSerial);
} 

void loop()
{
  
}