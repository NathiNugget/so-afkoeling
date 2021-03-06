  // Graphing sketch

  // This program takes ASCII-encoded strings from the serial port at 9600 baud
  // and graphs them. It expects values in the range 0 to 1023, followed by a
  // newline, or newline and carriage return

  // created 20 Apr 2005
  // updated 24 Nov 2015
  // by Tom Igoe
  // This example code is in the public domain.

  import processing.serial.*;
PrintWriter output;
float voltage;
float temperatur;
float time;
float start_time;
//float to_print;
 
  Serial myPort;        // The serial port
  int xPos = 1;         // horizontal position of the graph
  float inByte = 0;

  void setup () {
    // set the window size:
    size(800, 900);
    // List all the available serial ports
    // if using Processing 2.1 or later, use Serial.printArray()
    println(Serial.list());

    // I know that the first port in the serial list on my Mac is always my
    // Arduino, so I open Serial.list()[0].
    // Open whatever port is the one you're using.
    myPort = new Serial(this, Serial.list()[0], 9600);

    // don't generate a serialEvent() unless you get a newline character:
    myPort.bufferUntil('\n');

    // set initial background:
    background(0);
    output = createWriter("opsamlede_data.txt"); 
   start_time=System.currentTimeMillis();

  }

  void draw () {
    // draw the line:
    stroke(127, 34, 255);
    line(xPos, height, xPos, height - inByte);
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      background(0);
    } else {
      // increment the horizontal position:
      xPos++;
    }
  }

  void serialEvent (Serial myPort) {
    // get the ASCII string:
    String inString = myPort.readStringUntil('\n');

    if (inString != null) {
      // trim off any whitespace:
      inString = trim(inString);
      // convert to an int and map to the screen height:
      inByte = float(inString);
      voltage=(inByte/1024.0)*5.0;
     temperatur=((voltage*100)-273); 
       time = millis();
       println(time);
     println(temperatur);
     println(voltage);
      println(inByte);
      output.flush();
      str(time);
      str(temperatur);
      output.println("tid"+" "+str(time)+" "+"temperatur"+" "+str(temperatur));
//      output.println(temperatur);
//output.println(time);
      delay(15000);
    }
  }
  
  void keyPressed() {
   // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}