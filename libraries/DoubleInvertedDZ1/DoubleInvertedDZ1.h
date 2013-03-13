#ifndef DoubleInvertedDZ1_h
#define DoubleInvertedDZ1_h

#include <ControlLoop.h>

// Initial Gains
#define B1_THETA_INIT	(0)
#define	B2_THETA_INIT	(0)
#define B1_PHI_INIT		(0)
#define	B2_PHI_INIT		(0)
#define A2_INIT			(0)
#define R_SHIFT_INIT	(0)
#define CONTROL_SHIFT	(0)

class DoubleInvertedDZ1 : public ControlLoop
{
  public:
    DoubleInvertedDZ1(void);
	
	// preSample: called during the previous sample, after control output is finished, to prepare for next sample
    virtual void preSample();
	
	// postSample: called after sample. Passed sensor data. Returns control output for this sample.
    virtual int16_t postSample(int16_t bottomAngle, int16_t topAngle);
	
	virtual void parseTuning( Stream* stream );
	
	virtual void getInfo( Stream* stream );
	
  private:
	int16_t b1_theta;
	int16_t b2_theta;
	int16_t b1_phi;
	int16_t b2_phi;
	int16_t a2;
	uint8_t rShift;
	
	int16_t prevBottomAngle;
	int16_t prevTopAngle;
	int16_t control;
};

#endif // DoubleInvertedDZ1_h