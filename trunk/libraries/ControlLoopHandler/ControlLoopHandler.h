#ifndef ControlLoopHandler_h
#define ControlLoopHandler_h

#include <ControlLoop.h>

#define BOTTOM_POT_PIN	0
#define TOP_POT_PIN		1

#define BOTTOM_POT_OFFSET	520
#define TOP_POT_OFFSET		256

// Uses timer2(8 bit) for control loop interrupt
// Timer1 is used for PWM (pins 9 and 10)
// Timer0 is used for delay(), millis(), micros()

// 500Hz sampling rate
void SetControlLoop(ControlLoop* cLoop);

// set the speed and turn for the robot. 
//Written from the background task. Can be used for RC control or higher level actions.
void setSped(int16_t sped);
void setTurn(int16_t turn);
void parseTuning( Stream* steam);

void EmergencyStop(void);

#endif // ControlLoopHandler_h