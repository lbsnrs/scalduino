/*

  Copyright (c) 2009 andreas@towel.it
  This sketch is released under the MIT license.
  
  Simple arduino sketch to control the current temperature from a LM35 sensor and 
  open/close a single solid state relay. I wrote this for a proofing box I use to 
  leaven my dough, but can be used in every case you need to heat up or cool down
  something (Green house? Reptilarium? You name it). Just connect the relay to an
  heater or cooler device, set the temperatures below and adjust the pin numbers 
  to match your setup, verify and upload the sketch and you are all set. 
  
  Have fun! :-)

*/

int pin = 0;       // pin to read t from
int relayPin = 12; // relay pin
int tmin = 20;     // Turn ON the light when t < tmin
int tmax = 22;     // Turn OFF the heater when t > tmax

/* initialize some var */
int t = 0;         // we store the temperature here
int foo = 0;       // cool name, isn't it?
int samples[10];
int i;

void setup()
{
  Serial.begin(9600);
  pinMode(relayPin, OUTPUT);
}

void loop()
{
  i = 0;
  while (i < 10) // Get 10 samples of the temperature
  {
    samples[i] = ( 5.0 * analogRead(pin) * 100.0) / 1024.0;
    t = t + samples[i];
    i++;

    delay(500);
  }

  t = t/10.0; // Calculate the average temp

  if (t >= tmax)  foo = 1;
  else if (t <= tmin) foo = 2;

  // We print the current temperature. One could hook up an LCD... I don't have one.
  Serial.print(t,DEC);
  Serial.println("C");

  switch (foo)
  {
    case 1:
      //Serial.println("Heater OFF");
      digitalWrite(relayPin, LOW);
      break;
    case 2:
      //Serial.println("Heater ON");
      digitalWrite(relayPin, HIGH);
      break;
  }

  t = 0;
  delay(1000);

}
