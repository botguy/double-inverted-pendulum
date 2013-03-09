// DualMotorCtlr Class

#ifndef DualMotorCtlr_h
#define DualMotorCtlr_h

#include "Arduino.h"

// Use timer1 for PWM (pins 9 and 10)
#define   b1    11
#define   b2    8
#define   bPWM  9

#define   a1    13
#define   a2    12
#define   aPWM  10

#define PWM_MAX	0x00FF

void DualMotorInit(void);


// sped and turn between [-255, 255]
void DualMotorControl(int16_t sped, int16_t turn);

#endif // DualMotorCtlr_h
