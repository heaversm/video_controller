import processing.video.*;// import video library
import processing.serial.*;// import serial library

Movie myMovie; // The movie object
float timeJump = 0.0; // amount of time that is displaced when scrubbing the movie in reverse
float timePrevious = 0.0; // the last position of the playhead
float videoSpeed = 0.0; // the speed at which the video plays
float maxSpeed = 5.0;
float minSpeed = 0;
Serial myPort; // The serial port

void setup() {
  size(640, 480);
  // Load and play the video in a loop
  myMovie = new Movie(this, "station.mov");
  myMovie.loop();
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void movieEvent(Movie myMovie) {
  myMovie.read();
}

void draw() {
 myMovie.speed(videoSpeed);
 image(myMovie, 0, 0, width, height);
 timePrevious = myMovie.time();
}

/**
* serialEvent
*
* This function access the values coming in from the serial port
* It assigns the values to the play speed of the video, called videoSpeed
* These values are determined by the minSpeed and maxSpeed variables
* If you alter them you can change the range of speed the video will play
* For this to work, an Arduino must be sending one byte through the serial port
*/

void serialEvent (Serial myPort) {
// get the byte:
 int inByte = myPort.read();
 videoSpeed = map(inByte, 0, 255, minSpeed, maxSpeed);
 videoSpeed = constrain(videoSpeed, minSpeed, maxSpeed);
 println(inByte);
}
