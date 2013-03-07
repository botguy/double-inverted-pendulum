#include "Arduino.h"
#include <SingleInvertedPD.h>

//constructor
SingleInvertedPD::SingleInvertedPD(void)
{
	gCur = 0;
	gPrev = 0;
	rShift = 0;
	prevBottomAngle = 0;
	control = 0;
}

// preSample: called during the previous sample, after control output is finished, to prepare for next sample
void SingleInvertedPD::preSample(void)
{
	control = gPrev*prevBottomAngle;
}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t SingleInvertedPD::postSample(int16_t bottomAngle, int16_t topAngle)
{
	// calculate control
	control +=gCur*bottomAngle;
	
	// refresh previous data
	prevBottomAngle = bottomAngle;
	
	// output control
	return (control >> rShift);
}


void SingleInvertedPD::parseTuning( Stream* stream )
{
	int16_t k,b;

	Serial.println("PD parsing");
	
	// read tunings
	k = (int16_t)stream->parseInt();
	b = (int16_t)stream->parseInt();
	rShift = (uint8_t)stream->parseInt();

	// calculate gains
	gCur = k + b;
	gPrev = -b;
	
	// print gains
	stream->print(gCur);
	stream->print(' ');
	stream->print(gPrev);
	stream->print(' ');
	stream->print(rShift);
	stream->print('\n');	
}