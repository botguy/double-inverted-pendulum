#ifndef SingleInvertedPD_h
#define SingleInvertedPD_h

#include <ControlLoop.h>

class SingleInvertedPD : public ControlLoop
{
  public:
    SingleInvertedPD(void);
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    virtual void preSample();
	
	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    virtual int16_t postSample(int16_t bottomAngle, int16_t topAngle);
	
	virtual void parseTuning( Stream* stream );
	
  private:
	int16_t gCur;
	int16_t gPrev;
	uint8_t rShift;
	
	int16_t prevBottomAngle;
	int16_t control;
};

#endif // SingleInvertedPD_h