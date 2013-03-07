#include "Arduino.h"
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <SingleInvertedPID.h>
#include <DualMotorCtlr.h>

void setup()
{
  SingleInvertedPID pid;
  SetControlLoop( &pid );  
}

void loop()
{
  
}

