import processing.video.*;
Capture video;
PImage img;
int x1 = 0;
int y1  = 0;
int x2 = width/2;
int y2 = height/2;
int speed = 2;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480, 15); 
  img = createImage(video.width,video.height, RGB);
  background(0);
  video.start();
}

void draw() {
  if (video.available()) {
    video.read();
  }

  loadPixels();
  video.loadPixels();
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y*video.width;

      float r, g, b;
      r = red (video.pixels[loc]);
      g = green (video.pixels[loc]);
      b = blue (video.pixels[loc]);

      float maxdist = random(50, 100);
      float d = dist(x, y, random(640), random(480));

      float adjustbrightness = (maxdist-d)/maxdist;
      r *= adjustbrightness;
      g *= adjustbrightness*2;
      b *= adjustbrightness*3;
//      r = constrain(r, 0, 255);
//      g = constrain(g, 0, 255);
//      b = constrain(b, 0, 255);

      color c = color(r, g, b);
      img.pixels[loc] = c;
    }
  }
  img.updatePixels();
  image(img,0,0);
}

