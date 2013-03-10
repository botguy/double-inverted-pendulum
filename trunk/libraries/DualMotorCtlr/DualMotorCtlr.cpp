#include "Arduino.h"
#include "DualMotorCtlr.h"

static void setupPWM(void);

void DualMotorInit(void)
{
  setupPWM();

  // initialize outputs to 0
  DualMotorControl(0,0);

  // enable outputs
  pinMode(a1    , OUTPUT);
  pinMode(a2    , OUTPUT);
  pinMode(aPwmPin  , OUTPUT);
  
  pinMode(b1    , OUTPUT);
  pinMode(b2    , OUTPUT);
  pinMode(bPwmPin  , OUTPUT);
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
  aPWM = right;
  
  digitalWrite(b1, left >  0);
  digitalWrite(b2, left <= 0);  
  left = abs(left);
  left = min(left, PWM_MAX);
  bPWM = left; 
}

// Bit set macro
#define b(x)	(1<<(x))

static void setupPWM(void)
{
  // Setup Timer1 for 10bit Phase correct PWM
  // PWM freq = (16e6)/(prescaler * 2 * 2^10) = 7.8kHz

  // Set CS1[2:0] = 001 for 1:1 prescaler
  TCCR1B = b(CS10);
  
  // Set WGM1[2:0] = 011 for 10 bit Phase correct PWM
  // turn on PWM on Pins 9 & 10
  TCCR1A = b(COM1A1) | b(COM1B1) | b(WGM11) | b(WGM10);
}
