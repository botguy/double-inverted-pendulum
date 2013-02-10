// DualMotorCtlr Class

#ifndef DualMotorCtlr_h
#define DualMotorCtlr_h

#include "Arduino.h"

#define   a1    8
#define   a2    9
#define   aPWM  10

#define   b1    12
#define   b2    13
#define   bPWM  11

void DualMotorInit(void);


// sped and turn between [-255, 255]
void DualMotorControl(int16_t sped, int16_t turn);

#endif // DualMotorCtlr_h
