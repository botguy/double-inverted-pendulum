#ifndef ControlLoop_h
#define ControlLoop_h

class ControlLoop
{
  public:
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    virtual void preSample();

	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    virtual int16_t postSample(int16_t bottomAngle, int16_t topAngle);

	virtual void parseTuning( Stream* stream );
	
	virtual void getInfo( Stream* stream );
};

#include <SingleInvertedPD.h>

#endif // ControlLoop_h