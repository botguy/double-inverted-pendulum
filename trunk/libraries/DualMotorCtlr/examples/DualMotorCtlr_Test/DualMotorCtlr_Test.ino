//#include "Ardunio.h"
#include <DualMotorCtlr.h>

int16_t turn, sped;

void printControl(void);

void setup ()
{
  DualMotorInit();
  turn = 0;
  sped = 0;
  
  Serial.begin(9600); 
}

void loop()
{
   for(; turn< 256; turn++)
   {
       DualMotorControl(sped, turn);
       printControl();
   }
   
   for(; sped< 256; sped++)
   {
       DualMotorControl(sped, turn);
       printControl();
   }
   
   for(; turn > -256; turn--)
   {
       DualMotorControl(sped, turn);
       printControl();
   }
   
   for(; sped > -256; sped--)
   {
       DualMotorControl(sped, turn);
       printControl();
   }

   for(; turn< 0; turn++)
   {
       DualMotorControl(sped, turn);
       printControl();
   }
   
   for(; sped< 0; sped++)
   {
       DualMotorControl(sped, turn);
       printControl();
   }
   
}

 
 
void printControl(void)
{
       Serial.print(sped);
       Serial.print(", ");
       Serial.println(turn);
       delay(1);
}
