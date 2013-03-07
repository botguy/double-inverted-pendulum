
#include <SoftwareSerial.h>
#include <Bluetooth.h>
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <SingleInvertedPD.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>
#include <RcControl.h>


void setup() 
{ 
  Serial.begin(9600);
  startDataLogging();
//  setupBlueToothConnection();  
  
  SingleInvertedPD pd;
  SetControlLoop( (ControlLoop*)(&pd) );
} 

void loop()
{
 // RcControl(&blueToothSerial);
  RcControl(&Serial);
}
