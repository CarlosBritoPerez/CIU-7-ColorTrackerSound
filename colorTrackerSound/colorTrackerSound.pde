import processing.video.*;
import gifAnimation.*;
import processing.sound.*;

Capture cam;

color trackedColor; 
float threshold = 5;

int camX, camY;
int camWidth, camHeight;

int currentPosX, currentPosY;

String state = "INTRO";

SoundFile  music;
float amp = 0.1;


void setup() {
  size(1280, 960);
  String[] cameras = Capture.list();
  printArray(cameras);
  cam = new Capture(this, cameras[0]);
  cam.start();
  trackedColor = color(255, 0, 0);
  
  music = new SoundFile(this,"Casio-MT-45-Disco.wav");
  music.amp(amp);
  music.loop();
  
  camWidth = cam.width;
  camHeight = cam.height;
  camX = 320;
  camY = 240;
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {  
  switch(state){
    case "INTRO":
      intro();
      break;
    case "TRACKER":
      tracking();
      break;
    case "STABILIZER":
      stabilizer();
      break;
    case "SOUND":
      soundMixer();
      break;
  }
}

void intro(){
  background(0);
  textSize(60);
  text("WELCOME TO COLOR TRACKER!", width/2-450, height/2-300);
  textSize(36);
  text("CONTROLS:", width/2-350, height/2-150);
  textSize(31);
  text("- CLICK to choose the color", width/2-280, height/2-100);
  text("- PRESS ENTER to start/stop", width/2-280, height/2-60);
  text("- PRESS TAB to swap between screens", width/2-280, height/2-20);
  textSize(36);
  text("MODES:", width/2-350, height/2+60);
  textSize(31);
  text("- In TRACKER you can move the camera around", width/2-280, height/2+100);
  text("- In STABILIZER it will try to keep the dot in the center", width/2-280, height/2+140);
  text("- In MIXER you can change the volume of the music", width/2-280, height/2+140);
  textSize(50);
  text("Press ENTER to start", width/2-250, height/2+300);
  

}

void tracking(){
  background(0);
  textSize(60);
  text("TRACKER", width/2-130, height/2-400);
  cam.loadPixels();
  image(cam, camX, camY, camWidth, camHeight);
  
  float avgX = 0;
  float avgY = 0;

  int count = 0;

  for (int x = 0; x < camWidth; x++ ) {
    for (int y = 0; y < camHeight; y++ ) {
      int loc = x + y * camWidth;
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackedColor);
      float g2 = green(trackedColor);
      float b2 = blue(trackedColor);

      float d = dist(r1, g1, b1, r2, g2, b2); 

      if (d < threshold) {;
        point(x+camX, y+camY);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX+camX, avgY+camY, 24, 24);
    
    if(avgX > camWidth/2 && camX < 1280-camWidth){
      camX += (avgX - camWidth/2)/50;
    }else if(avgX <= camWidth/2 && camX > 0){
      camX -= (camWidth/2 - avgX)/50;
    }
    
    if(avgY > camHeight/2 && camY < 960-camHeight){
      camY += (avgY - camHeight/2)/50;
    }else if(avgY <= camHeight/2 && camY > 0){
      camY -= (camHeight/2 - avgY)/50;
    }
  }
  
}

void stabilizer(){
  background(0);
  textSize(60);
  text("STABILIZER", width/2-160, height/2-400);
  cam.loadPixels();
  image(cam, camX, camY, camWidth, camHeight);

  float avgX = 0;
  float avgY = 0;
  int count = 0;

  for (int x = 0; x < camWidth; x++ ) {
    for (int y = 0; y < camHeight; y++ ) {
      int loc = x + y * camWidth;
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackedColor);
      float g2 = green(trackedColor);
      float b2 = blue(trackedColor);

      float d = dist(r1, g1, b1, r2, g2, b2); 

      if (d < threshold) {;
        point(x+camX, y+camY);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX+camX, avgY+camY, 24, 24);
    
    if(640 > avgX+camX && camX > 0){
      camX += (640 - (avgX+camX))/10;
    }else if(640 <= avgX+camX && camX < 1280-camWidth){
      camX -= ((avgX+camX) - 640)/10;
    }
    
    if(480 > avgY+camY && camY > 0){
      camY += (480 - (avgY+camY))/10;
    }else if(480 <= avgY+camY && camY < 960-camHeight){
      camY -= ((avgY+camY) - 480)/10;
    }
  }
  
}

void soundMixer(){
  background(0);
  textSize(60);
  text("MIXER", width/2-100, height/2-400);
  cam.loadPixels();
  camX = 320;
  camY = 240;
  image(cam, camX, camY, camWidth, camHeight);

  float avgX = 0;
  float avgY = 0;

  int count = 0;
  
  //plus
  rect(1080, 480, 100, 20);
  rect(1120, 440, 20, 100);
  
  //minus
  rect(100, 480, 100, 20);  
  
  for (int x = 0; x < camWidth; x++ ) {
    for (int y = 0; y < camHeight; y++ ) {
      int loc = x + y * camWidth;
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackedColor);
      float g2 = green(trackedColor);
      float b2 = blue(trackedColor);

      float d = dist(r1, g1, b1, r2, g2, b2); 

      if (d < threshold) {;
        point(x+camX, y+camY);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX+camX, avgY+camY, 24, 24);
    
    amp = avgX/1000;
       
    
    music.amp(amp);
    print(amp);
  }
  
  //soundbar
  rect(camX, 800, avgX, 20);
}

void mousePressed() {
  if(state == "TRACKER" || state == "STABILIZER" || state == "SOUND"){
    int loc = mouseX-camX + (mouseY-camY)*camWidth;
    trackedColor = cam.pixels[loc];
  }
}

void keyPressed() {
   if(key == ENTER){
    if(state == "TRACKER" || state == "STABILIZER"){
      state = "INTRO";
    }else if(state == "INTRO"){
      state = "TRACKER";
    }
   }
  if(key == TAB){
    if(state == "TRACKER" ){
      state = "STABILIZER";
    }else if(state == "STABILIZER"){
      state = "SOUND";
    }else if(state == "SOUND"){
      state = "TRACKER";
    }
  }
}

void music(){
  music.amp(amp);
  music.loop();
}
