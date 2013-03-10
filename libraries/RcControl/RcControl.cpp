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
				stream->println("Emergency Stop");
				break;
			
			case RESUME_FROM_EMERGENCY_STOP: // Resume from Emergency stop
				ResumeFromEmergencyStop();
				stream->println("Resume from Emergency Stop");
				break;			
			
			case PRINT_DATA_LOG: // print data log
				printDataLog( stream );
				break;
				
			case FORWARD:
				setSped(SPEED_MAGNITUDE);
				stream->println("Forward");
				break;
				
			case STOP:
				setSped( 0 );
				setTurn( 0 );
				stream->println("Stop");
				break;
				
			case BACK:
				setSped(-SPEED_MAGNITUDE);
				stream->println("Back");
				break;
				
			case LEFT:
				setTurn( TURN_MAGNITUDE );
				stream->println("Left");
				break;
				
			case RIGHT:
				setTurn(-TURN_MAGNITUDE );
				stream->println("Right");
				break;
			
			case UPLOAD_TUNING:
				parseTuning( stream );
				break;
				
			case GET_CTRL_LOOP_INFO:
				getCtrlLoopInfo( stream );
				break;
				
			case INCREMENT_BOTTOM_SETPOINT:
				stream->println(++BottomPotSetpoint);
				break;
				
			case DECREMENT_BOTTOM_SETPOINT:
				stream->println(--BottomPotSetpoint);
				break;
				
			case INCREMENT_TOP_SETPOINT:
				stream->println(++TopPotSetpoint);
				break;
				
			case DECREMENT_TOP_SETPOINT:
				stream->println(--TopPotSetpoint);
				break;

			default:
				break;
		}
	}
}