import processing.video.*;

String[] cameras = Capture.list();
Capture cam;

MS marchie;

void setup() {
  size(500, 400, P2D);
  background(0);
  
  marchie = new MS(3);
  cam = new Capture(this, cameras[0]);
  cam.start();
}

void draw() {
  background(0);
  cam.read();
  image(cam, 0, 0);
  loadPixels();
  background(0);
  marchie.run();
  
  println(frameRate);
  //saveFrame("output/RV_####.TIF");
}
