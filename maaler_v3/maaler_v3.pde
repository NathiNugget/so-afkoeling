import processing.serial.*;
PrintWriter output;
PrintWriter output2;
float voltage;
float temperatur;
float time;

  Serial myPort;        // The serial port
  int xPos = 1;         // horizontal position of the graph
  float inByte = 0;

  void setup () {
    // set the window size:
    size(800, 900);
    // List all the available serial ports
    println(Serial.list());

    myPort = new Serial(this, Serial.list()[0], 9600);

    // don't generate a serialEvent() unless you get a newline character:
    myPort.bufferUntil('\n');

    // set initial background:
    background(0);
    output = createWriter("opsamlede_data_temp.txt");
    output2=createWriter("opsamlede_data_tid.txt");
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
      output2.flush();
      output.println("temperatur"+" "+str(temperatur));
      output2.println("tid"+" "+str(time));
    }
  }
  
  void keyPressed() {
  output.close(); // Finishes the file
  exit(); // Stops the program
}