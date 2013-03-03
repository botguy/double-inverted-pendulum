#ifndef SingleInvertedPID_h
#define SingleInvertedPID_h

#include "ControlLoop.h"

class SingleInvertedPID : public ControlLoop
{
  public:
    SingleInvertedPID(void);
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    void preSample();
	
	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    int16_t postSample(int16_t bottomAngle, int16_t topAngle);
};

#endif // SingleInvertedPID_h