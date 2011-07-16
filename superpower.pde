#include "QuectelM10.h"
#include <NewSoftSerial.h>
#include "inetGSM.h"
/*#include "LOG.h"

 #define __LOG_LEVEL 5
 LOG logme(__LOG_LEVEL);
 */
/*
 * We should put here some copyright stuff.
 *
 * This program is developed just to test-develop the Arduino-TID-GSM libraries.
 */

InetGSM inet;
char response[200];
char* separator="#";
int numdata;

const int btnR = 4;     // the number of the pushbutton pin
const int btnU = 5;
const int btnL = 6;
const int ledPin =  13;      // the number of the LED pin
const int motorPinR = 9;
const int motorPinL= 10;
const int palaPin= 11;



void setup()
{
 delay(5000);
 pinMode(ledPin, OUTPUT);
 pinMode(motorPinR, OUTPUT);
 pinMode(motorPinL, OUTPUT);
 pinMode(palaPin, OUTPUT);
 // initialize the pushbutton pin as an input:
 pinMode(btnR, INPUT);
 pinMode(btnU, INPUT);
 pinMode(btnL, INPUT);


 //Serial connection.
 Serial.begin(9600);
 Serial.println("GSM Shield testing. Start the modem");
 delay(1000);
 if (gsm.begin())
   Serial.println("\nstatus=READY");
 else Serial.println("\nstatus=IDLE");
 if (gsm.attachGPRS("movistar.es", "movistar", "movistar"))
   Serial.println("\nstatus=ATTACHED");
 else Serial.println("\nstatus=ERROR");
 Serial.println("Initialized");
};

void loop()
{
 char command=' ';
 char* ptr;
 int sequeda=1;
 //      inet.httpGET("www.google.com",80,"/", response, 200);
 inet.httpGET("217.124.215.168",80,"/cgi-bin/superpower.py", response, 200);
 ptr=strtok(response, separator);
 ptr=strtok(NULL, separator);
 Serial.print("Respuesta:");
 Serial.println(response);
 if(ptr!=0)
 {
   command=*ptr;
   Serial.println(command);
 }
 if (command == 'w') {
   // turn LED on:
   digitalWrite(ledPin, HIGH);
   analogWrite(motorPinR, 250);
   analogWrite(motorPinL,250);
   sequeda=0;
 }
 else if (command == 'd'){
   // turn LED off:
   digitalWrite(ledPin, HIGH);
   analogWrite(motorPinR, 0);
   analogWrite(motorPinL, 250);
   sequeda=0;
 }
 else if (command == 'a'){
   // turn LED off:
   digitalWrite(ledPin, HIGH);
   analogWrite(motorPinL, 0);
   analogWrite(motorPinR, 250);
   sequeda=0;
 }
 else if (command == 's'){
   //mueve pala
   digitalWrite(palaPin,HIGH);
   delay(1500);
   digitalWrite(palaPin,LOW);
   sequeda=0;
 }
 
 else{
   // turn LED off:
   digitalWrite(ledPin, LOW);
   analogWrite(motorPinL, 0);
   analogWrite(motorPinR, 0);
 }
 digitalWrite(ledPin, HIGH);
 delay(500);
 digitalWrite(ledPin, LOW);
 delay(500);
 if(sequeda){
   digitalWrite(ledPin, HIGH);
   delay(200);
  } else {
   digitalWrite(ledPin, LOW);
   delay(200);
  }

};
