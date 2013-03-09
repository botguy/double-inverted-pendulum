#include "Arduino.h"
#include <RcControl.h>
#include <ControlLoopHandler.h>
#include <DataLog.h>

void RcControl( Stream* stream )
{
	if( stream->available() ) // input data from USB or bluetooth serial
	{
		char recieveChar = stream->read();
		switch( recieveChar )
		{
			case EMERGENCY_STOP: // Emergency stop
				EmergencyStop();
				break;
				
			case PRINT_DATA_LOG: // print data log
				printDataLog( stream );
				break;
				
			case FORWARD:
				setSped(SPEED_MAGNITUDE);
				break;
				
			case STOP:
				setSped( 0 );
				setTurn( 0 );
				break;
				
			case BACK:
				setSped(-SPEED_MAGNITUDE);
				break;
				
			case LEFT:
				setTurn( TURN_MAGNITUDE );
				break;
				
			case RIGHT:
				setTurn(-TURN_MAGNITUDE );
				break;
			
			case UPLOAD_TUNING:
				parseTuning( stream );
				break;
				
			case GET_CTRL_LOOP_INFO:
				getCtrlLoopInfo( stream );
				break;

			default:
				break;
		}
	}
}