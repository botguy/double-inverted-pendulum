#include "Arduino.h"
#include <DoubleInvertedDZ1.h>

//constructor
DoubleInvertedDZ1::DoubleInvertedDZ1(void)
{
	b1_theta = B1_THETA_INIT;
	b2_theta = B2_THETA_INIT;
	b1_phi = B1_PHI_INIT;
	b2_phi = B2_PHI_INIT;
	a2 = A2_INIT;
	rShift = R_SHIFT_INIT;
	prevBottomAngle = 0;
	prevTopAngle = 0;
	control = 0;
}

// preSample: called during the previous sample, after control output is finished, to prepare for next sample
void DoubleInvertedDZ1::preSample(void)
{
	control = b2_theta*prevBottomAngle + b2_phi*prevTopAngle + a2*( control >> CONTROL_SHIFT );
}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t DoubleInvertedDZ1::postSample(int16_t bottomAngle, int16_t topAngle)
{
	// calculate control
	control +=b1_theta*bottomAngle;
	control +=b1_phi*topAngle;
	
	// refresh previous data
	prevBottomAngle = bottomAngle;
	prevTopAngle = topAngle;
	
	// output control
	return (control >> rShift);
}


void DoubleInvertedDZ1::parseTuning( Stream* stream )
{
	int16_t k,b;

	// read tunings
	k = (int16_t)stream->parseInt();
	b = (int16_t)stream->parseInt();
	a2 = (int16_t)stream->parseInt();
	rShift = (uint8_t)stream->parseInt();

	// calculate gains
	b1_theta = k + b;
	b2_theta = -b;

	this->getInfo( stream );
}

void DoubleInvertedDZ1::getInfo( Stream* stream )
{
	stream->println("\nDZ1 control Loop");
	stream->print("b1_theta = ");
	stream->print(b1_theta);
	stream->print("\t\tb2_theta = ");
	stream->println(b2_theta);
	stream->print("b1_phi = ");
	stream->print(b1_phi);
	stream->print("\t\tb2_phi = ");
	stream->println(b2_phi);
	
	stream->print("b1 = 2^");
	stream->print(rShift);
	stream->print("\ta2 = ");		
	stream->println(a2);
}