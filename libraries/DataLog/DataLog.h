#ifndef DataLog_h
#define DataLog_h

#define NUM_DATA_POINTS	100

// Data Logging
void startDataLogging(void);
void stopDataLogging(uint16_t numInterrupts);
void logData(int16_t data);
void printDataLog(void);

#endif // DataLog_h