#include <SoftwareSerial.h>   //Software Serial Port
#include <ControlLoopHandler.h>
#include <ControlLoop.h>
#include <SingleInvertedPID.h>
#include <DualMotorCtlr.h>
#include <DataLog.h>


#define RxD 6
#define TxD 7
 
//#define DEBUG_ENABLED  1
//SoftwareSerial blueToothSerial(RxD,TxD);

void setup() 
{ 
  Serial.begin(9600);
  startDataLogging();
  //setupBlueToothConnection();  
  
  SingleInvertedPID pid;
  SetControlLoop( &pid );
  
  Serial.println("start");
  delay(1000);
  Serial.println("stop");
  stopDataLogging(0);
  printDataLog();
} 

void loop()
{

}
/* 
void setupBlueToothConnection()
{
  pinMode(RxD, INPUT);
  pinMode(TxD, OUTPUT);
  
  blueToothSerial.begin(38400); //Set BluetoothBee BaudRate to default baud rate 38400
  blueToothSerial.print("\r\n+STWMOD=0\r\n"); //set the bluetooth work in slave mode
  blueToothSerial.print("\r\n+STNA=SeeedBTSlave\r\n"); //set the bluetooth name as "SeeedBTSlave"
  blueToothSerial.print("\r\n+STOAUT=1\r\n"); // Permit Paired device to connect me
  blueToothSerial.print("\r\n+STAUTO=0\r\n"); // Auto-connection should be forbidden here
  delay(2000); // This delay is required.
  blueToothSerial.print("\r\n+INQ=1\r\n"); //make the slave bluetooth inquirable 
  Serial.println("The slave bluetooth is inquirable!");
  delay(2000); // This delay is required.
  blueToothSerial.flush();
  
  while(!blueToothSerial.available()); // wait for avaliable
  (void) blueToothSerial.read();
}

*/


