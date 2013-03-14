#ifndef SingleInvertedDZ1_h
#define SingleInvertedDZ1_h

#include <ControlLoop.h>

// Initial Gains
#define B1_INIT		   	(550)
#define	B2_INIT	  		(-150)
#define A2_INIT			(3)
#define R_SHIFT_INIT	(2)
#define CONTROL_SHIFT	(4)
/*
#define B1_INIT		   	(0)
#define	B2_INIT	  		(0)
#define A2_INIT			(0)
#define R_SHIFT_INIT	(3)
#define CONTROL_SHIFT	(4)
*/
class SingleInvertedDZ1 : public ControlLoop
{
  public:
    SingleInvertedDZ1(void);
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    virtual void preSample();
	
	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    virtual int16_t postSample(int16_t bottomAngle, int16_t topAngle);
	
	virtual void parseTuning( Stream* stream );
	
	virtual void getInfo( Stream* stream );
	
  private:
	int16_t b1;
	int16_t b2;
	int16_t a2;
	uint8_t rShift;
	
	int16_t prevBottomAngle;
	int16_t control;
};

#endif // SingleInvertedDZ1_h