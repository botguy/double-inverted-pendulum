#include "Arduino.h"
#include <SingleInvertedFullState.h>

//constructor
SingleInvertedFullState::SingleInvertedFullState(void)
{
	b1 = B1_INIT;
	b2 = B2_INIT;
	a2 = A2_INIT;
	speedFB = SPEED_FB_INIT;
	rShift = R_SHIFT_INIT;
	prevBottomAngle = 0;
	control = 0;
}

// preSample: called during the previous sample, after control output is finished, to prepare for next sample
void SingleInvertedFullState::preSample(void)
{
	control = b2*prevBottomAngle + a2*( control >> CONTROL_SHIFT );
}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t SingleInvertedFullState::postSample(int16_t bottomAngle, int16_t topAngle)
{
	// calculate control
	control +=b1*bottomAngle;
	
	// Speed feedback
	// Motor speed fed into topPot ADC input.
	control += speedFB*topAngle;
	
	// refresh previous data
	prevBottomAngle = bottomAngle;
	
	// output control
	return (control = control >> rShift);
}


void SingleInvertedFullState::parseTuning( Stream* stream )
{
	int16_t k,b;

	// read tunings
	k = (int16_t)stream->parseInt();
	b = (int16_t)stream->parseInt();
	a2 = (int16_t)stream->parseInt();
	rShift = (uint8_t)stream->parseInt();
	speedFB = (int16_t)stream->parseInt();

	// calculate gains
	b1 = k + b;
	b2 = -b;

	this->getInfo( stream );
}

void SingleInvertedFullState::getInfo( Stream* stream )
{
	stream->println("\nFull State Feedback control Loop");
	stream->print("b1 = ");
	stream->print(b1);
	stream->print("\t\tb2 = ");
	stream->println(b2);
	
	stream->print("a1 = 2^");
	stream->print(rShift);
	stream->print("\ta2 = ");		
	stream->println(a2);
	
	stream->print("\tspeedFB = ");		
	stream->println(speedFB);
}