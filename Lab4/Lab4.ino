extern byte val;
extern byte width;
extern byte ascii;

extern "C" { 
  void Eureka();
  void decode_morse();
}

//
// function to read a 2-digit decimal value from user
//
byte read2DigitValue()
{
  byte inch; int val;
  Serial.println("Enter a 2-digit decimal value:");
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val = (inch - '0') * 10;
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val += (inch - '0');
  Serial.print("The value entered is ");
  Serial.println(val,DEC);
  return (byte) val;
}

void flashEureka() 
{
  // Add you code here
  Eureka();
  // You will call the Eureka() function in assembly
}

void decodeMorse(const String & string, char message[])
{
  // Write your code below.
  // string contains the input binary string separated by single spaces
  // message contains the decoded English characters and numbers  
  ///*
  val = 0;     //set to 0
  width = 0;
  int x = 0;  //for adding to message array
  for(int i = 0; i <= string.length(); i++){
    char c = string[i]; //take char at i

    if(c == '1'){    //if is 1, inc width and val
      width++;
        val = val * 2 + 1;
    }
    else if(c == '0'){  //if is 0 inc with and val
      width++;
        val = val * 2;
    }
    else{
      decode_morse();  //call decode morse to find ascii val
        val = 0;   //set to 0 for next num
        width = 0;
        message[x++] = ascii;  //put decoded character into message
    }
  }
  message[x] = '\0';
  //*/
  // You will call the assembly function decode_morse()
}

void decodeMorse() 
{
  Serial.println("Input a Morse code string (separate the code for characters by a space):");

  while (!Serial.available()) delay(100);
  String string = Serial.readString();

  Serial.print("The Morse code string is: ");
  Serial.println(string);

  //string = "1000 100 0 01 1000";
  char message[100];

  decodeMorse(string, message);

  if(strlen(message) > 0) {
    Serial.print("The decoded message is: ");
    Serial.println(message);
  } else {
    Serial.print("Failure in decoding the input Morse code\n");
  }  
}

void setup() {
  //
  // Initialize serial communications
  //
  Serial.begin(9600);

  flashEureka();

  decodeMorse();
  
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(20000); // 20,000 millisecs == 20 seconds
  Serial.println("*");
}
