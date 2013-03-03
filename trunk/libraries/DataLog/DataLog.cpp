#include "Arduino.h"
#include <DataLog.h>

boolean loggingData;
int16_t buffer[NUM_DATA_POINTS];
uint16_t index;

void startDataLogging(void)
{
	// clear buffer
	for(uint16_t i = 0; i<NUM_DATA_POINTS; i++)
	{
		buffer[i] = 0;
	}
	
	// start logging
	index = 0;
	loggingData = 1;
}

// Data Logging
void stopDataLogging(uint16_t numInterrupts)
{
	loggingData = 0;
}

void logData(int16_t data)
{
	if( loggingData )
	{
		buffer[index] = data;
		
		index ++;
		if(index >= NUM_DATA_POINTS)
		{
			index = 0;
		}
	}
}

#define NUM_DATA_ITEMS	4	
void printDataLog(void)
{
	uint16_t j = index;
	uint8_t k = 0;
	
	do
	{
		Serial.print(buffer[j]);
		
		// current data item in line
		k++;
		if(k >= NUM_DATA_ITEMS)
		{
			Serial.print("\n");
			k = 0;
		}
		else
		{
			Serial.print("\t");
		}
	
		//current index in buffer
		j++;
		if(j >= NUM_DATA_POINTS)
		{
			j = 0;
		}
	}while(j != index);

	startDataLogging();
}