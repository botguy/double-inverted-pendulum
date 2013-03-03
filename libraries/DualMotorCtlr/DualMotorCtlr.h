// DualMotorCtlr Class

#ifndef DualMotorCtlr_h
#define DualMotorCtlr_h

#include "Arduino.h"

// Use timer1 for PWM (pins 9 and 10)
#define   a1    8
#define   a2    11
#define   aPWM  9

#define   b1    12
#define   b2    13
#define   bPWM  10

void DualMotorInit(void);


// sped and turn between [-255, 255]
void DualMotorControl(int16_t sped, int16_t turn);

#endif // DualMotorCtlr_h
