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
	control = b2_theta*prevBottomAngle + a2*( control >> CONTROL_SHIFT );
	if( abs(prevTopAngle) < 30 )
	{
		control += b2_phi*prevTopAngle;
	}
}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t DoubleInvertedDZ1::postSample(int16_t bottomAngle, int16_t topAngle)
{
	// calculate control
	control +=b1_theta*bottomAngle;
	if( abs(prevTopAngle) < 30 )
	{
		control +=b1_phi*topAngle;
	}
	
	// refresh previous data
	prevBottomAngle = bottomAngle;
	prevTopAngle = topAngle;
	
	// output control
	return (control = control >> rShift);
}


void DoubleInvertedDZ1::parseTuning( Stream* stream )
{
	int16_t k_theta,b_theta;
	int16_t k_phi,b_phi;

	// read tunings
	k_theta = (int16_t)stream->parseInt();
	b_theta = (int16_t)stream->parseInt();
	k_phi = (int16_t)stream->parseInt();
	b_phi = (int16_t)stream->parseInt();
	a2 = (int16_t)stream->parseInt();
	rShift = (uint8_t)stream->parseInt();

	// calculate gains
	b1_theta = k_theta + b_theta;
	b2_theta = -b_theta;

	// calculate gains
	b1_phi = k_phi + b_phi;
	b2_phi = -b_phi;
	
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
	
	stream->print("a1 = 2^");
	stream->print(rShift);
	stream->print("\ta2 = ");		
	stream->println(a2);
}