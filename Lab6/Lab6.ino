

extern "C"{
  void initSensor();
  byte readSensor(byte);
  void waitOneSecond();
}

void setup() 
{    
  Serial.begin(9600);    
  initSensor();  // call assembly to initialize the sensor 

}



void loop() 
{   
  byte v;
  v = readSensor(2); // call assembly to read sensor value, A/D pin #2         
  Serial.print(" light = ");
  Serial.println(v,HEX);
  waitOneSecond();
}
