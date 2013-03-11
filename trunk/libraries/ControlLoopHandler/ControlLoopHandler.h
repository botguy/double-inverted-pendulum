#ifndef ControlLoopHandler_h
#define ControlLoopHandler_h

#include <ControlLoop.h>

#define BOTTOM_POT_PIN	0
#define TOP_POT_PIN		2

extern uint16_t BottomPotSetpoint;
extern uint16_t TopPotSetpoint;

#define BOTTOM_POT_SETPOINT_INIT	523
#define TOP_POT_SETPOINT_INIT		256

// Uses timer2(8 bit) for control loop interrupt
// Timer1 is used for PWM (pins 9 and 10)
// Timer0 is used for delay(), millis(), micros()

// 500Hz sampling rate
void SetControlLoop(ControlLoop* ctrlLoop);

// set the speed and turn for the robot. 
//Written from the background task. Can be used for RC control or higher level actions.
void setSped(int16_t sped);
void setTurn(int16_t turn);
void parseTuning( Stream* steam);
void getCtrlLoopInfo( Stream* stream );

void EmergencyStop(void);
void ResumeFromEmergencyStop(void);

#endif // ControlLoopHandler_h