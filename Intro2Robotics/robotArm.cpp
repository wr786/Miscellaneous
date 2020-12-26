/*
  Controlling a servo position using a potentionmeter (variable resistor)
*/
#include <Servo.h>

/* Create servo object to control a servo */
Servo myservo;

/* analog pin used to connect the potentionmeter */
int potpin = 0;
/* variable to read the value from the analog pin */
double val;

void setup() {
  /* attaches the servo on pin 9 to the servo object */
  myservo.attach(9);
//  Serial.begin(9600);
}

void loop() {
  /* Reads the value of the potentionmeter
     (value b/w 0 and 1023) */
  val = analogRead(potpin);
//  Serial.println(val);
  /* Scale it to use it with the servo
     (value b/w 0 and 180) */
  int arg1 = 100, arg2 = 300, arg3 = 40, arg4 = 180;
  double k1, k2, k3, k4;
  k1 = k2 = 0.5;
  k3 = k4 = 0.2;
  val = map(val, k1 * arg1, k2 * arg2, k3 * arg3, k4 * arg4);
  /* Sets the servo position according to the scaled value */
  myservo.write(val);
  /* waits for the servo to get there */
  int delayTime = 10;
  delay(delayTime);
}