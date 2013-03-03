#include "Arduino.h"
#include <SingleInvertedPID.h>

//constructor
SingleInvertedPID::SingleInvertedPID(void)
{

}

// preSample: called during the previous sample, after control output is finished, to prepare for next sample
void SingleInvertedPID::preSample(void)
{

}

// postSample: called after sample. Passed sensor data. Returns control output for this sample.
int16_t SingleInvertedPID::postSample(int16_t bottomAngle, int16_t topAngle)
{
	return 0;
}
