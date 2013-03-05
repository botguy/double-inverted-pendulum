#ifndef DataLog_h
#define DataLog_h

// configuration parameters
#define RECORD_TIME_MS			(250ull)	// record for 250ms
#define NUM_RECORDED_SIGNALS	(4) 	// record 4 variables
#define SAMPLING_RATE			(500) 	// 500Hz sampling rate

// computed parameters
#define NUM_DATA_POINTS			(NUM_RECORDED_SIGNALS * SAMPLING_RATE * RECORD_TIME_MS / 1000) 	// 0.25 second of 4 data points at 500Hz

// Data Logging
void startDataLogging(void);
void stopDataLogging(uint16_t numInterrupts);
void logData(int16_t data);
void printDataLog(void);

#endif // DataLog_h