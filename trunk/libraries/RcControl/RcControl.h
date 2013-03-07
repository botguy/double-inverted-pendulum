#ifndef RcControl_h
#define RcControl_h

// Allows remote control through USB or Bluetooth serial
// Run in the background task

// Tunings
#define SPEED_MAGNITUDE	50
#define	TURN_MAGNITUDE	20

// Commands:
#define EMERGENCY_STOP	' '
#define	PRINT_DATA_LOG  'p'

#define FORWARD			'w'
#define STOP			's'
#define BACK			'x'
#define LEFT			'a'
#define RIGHT			'd'

#define UPLOAD_TUNING	't'

void RcControl( Stream* stream );



#endif // RcControl_h