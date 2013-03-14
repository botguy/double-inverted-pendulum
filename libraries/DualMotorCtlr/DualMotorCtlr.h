// DualMotorCtlr Class

#ifndef DualMotorCtlr_h
#define DualMotorCtlr_h

#include "Arduino.h"

// Use timer1 for PWM (pins 9 and 10)
#define   b1    	11
#define   b2    	8
#define	  bPwmPin	9
#define	  bPWM  	OCR1A // Pin 9

#define   a1    	13
#define   a2    	12
#define	  aPwmPin	10
#define   aPWM  	OCR1B // Pin 10


// 10-bit PWM
#define PWM_MAX	0x03FF

void DualMotorInit(void);


// forward and turn between [-255, 255]
void DualMotorControl(int16_t forward, int16_t turn);

#endif // DualMotorCtlr_h
