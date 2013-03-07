#ifndef ControlLoop_h
#define ControlLoop_h

class ControlLoop
{
  public:
//    ControlLoop(void);
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    void preSample();
	
	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    int16_t postSample(int16_t bottomAngle, int16_t topAngle);

	virtual void parseTuning( Stream* stream );
};

#include <SingleInvertedPD.h>

#endif // ControlLoop_h