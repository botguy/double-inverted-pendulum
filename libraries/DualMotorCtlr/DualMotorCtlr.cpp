#include "Arduino.h"
#include "DualMotorCtlr.h"

void DualMotorInit(void)
{
  // initialize outputs to 0
  DualMotorControl(0,0);

  // enable outputs
  pinMode(a1    , OUTPUT);
  pinMode(a2    , OUTPUT);
  pinMode(aPWM  , OUTPUT);
  
  pinMode(b1    , OUTPUT);
  pinMode(b2    , OUTPUT);
  pinMode(bPWM  , OUTPUT);
}

void DualMotorControl(int16_t sped, int16_t turn)
{
  int16_t right, left;
  
  right = sped + turn;
  left  = sped - turn;
  
  digitalWrite(a1, right >  0);
  digitalWrite(a2, right <= 0);
  right = abs(right);
  right = min(right, PWM_MAX);
  analogWrite(aPWM, (right & PWM_MAX));
  
  digitalWrite(b1, left >  0);
  digitalWrite(b2, left <= 0);  
  left = abs(left);
  left = min(left, PWM_MAX);
  analogWrite(bPWM, (left & PWM_MAX)); 
}
