#include "Arduino.h"
#include <ControlLoop.h>

// preSample: called during the previous sample, after control output is finished, to prepare for next sample
void ControlLoop::preSample(void)
{

}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t ControlLoop::postSample(int16_t bottomAngle, int16_t topAngle)
{
	return 0;
}

void ControlLoop::parseTuning( Stream* stream )
{
	stream->println("ControlLoop parsing");
}


void ControlLoop::getInfo( Stream* stream )
{
	stream->println("No Control Loop");
}