#include "Arduino.h"
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>

static void setupTimer2(void);

ControlLoop* cLoop;
int16_t sped;
int16_t turn;

void SetControlLoop(ControlLoop* ctrlLoop)
{
	noInterrupts(); // disable interrupts

	cLoop = ctrlLoop;
	DualMotorInit();
	DualMotorControl(0,0);
	
	setupTimer2();
	
	interrupts(); // enabled interrupts
}

// Target sampling rate: 500Hz
// Clock prescaler set to 128 -> 62.5kHz timer2 clock based on 16Mhz system clock
// For 128 prescaler, set CS22:CS20 = 101 according to table 18-9 in Atmel ATmega328p datasheet
// interrupt triggers every 250 counts to produce 500Hz interrupt.
// interrupt register set to 249 since it starts from zero.
static void setupTimer2(void)
{
	//set timer2 interrupt at 62.5kHz
	TCCR2A = 0;// set entire TCCR2A register to 0
	TCCR2B = 0;// same for TCCR2B
	TCNT2  = 0;//initialize counter value to 0
	
	// set compare match register for 500Hz
	OCR2A = 249;// = ((16e6) / (500*128)) - 1 //(must be <256)
	// turn on CTC mode
	TCCR2A |= (1 << WGM21);
	// Set CS12 bit for 256 prescaler
	TCCR2B |= ((1 << CS22) | (1 << CS20));
	// enable timer compare interrupt
	TIMSK2 |= (1 << OCIE2A);
}

// 500Hz ISR
ISR(TIMER2_COMPA_vect)
{
	int16_t bottomAngle; 
	int16_t topAngle;
	int16_t control;
	
	// Read sensors
	bottomAngle = (int16_t)analogRead(BOTTOM_POT_PIN) - BOTTOM_POT_OFFSET;
	topAngle = (int16_t)analogRead(TOP_POT_PIN) - TOP_POT_OFFSET;
	
	// Call control cLoop
	control = cLoop->postSample(bottomAngle, topAngle);
	
	// output control
	DualMotorControl( sped + control, turn );
	
	// Prepare for next sample
	cLoop->preSample();
	
	// log data
	logData((int16_t) micros());
	logData(bottomAngle);
	logData(topAngle);
	logData(control);
}

void EmergencyStop(void)
{
	//turn off interrupts
	noInterrupts();

	// set motor output to zero
	DualMotorControl(0,0);
}

void setSped(int16_t newSped)
{	
	noInterrupts(); //turn off interrupts
	sped = newSped;
	interrupts(); //turn on interrupts
}

void setTurn(int16_t newTurn)
{	
	noInterrupts(); //turn off interrupts
	turn = newTurn;
	interrupts(); //turn on interrupts
}

void parseTuning( Stream* stream )
{
	cLoop->parseTuning( stream );
}

void getCtrlLoopInfo( Stream* stream )
{
	cLoop->getInfo( stream );
}
