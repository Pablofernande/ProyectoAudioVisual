
import processing.video.*;

Capture video;
color colorArma;


void setup() {
  size(640, 480);
  
 video = new Capture(this, 640, 480);
 video.start();
  
}

void captureEvent(Capture video) {
 video.read();
}


void draw() {
  pushMatrix();
  scale(-1, 1);
 video.loadPixels();
 image(video, -video.width, 0);
 popMatrix();
  escanearPixeles();

}
void escanearPixeles(){
  float worldRecord=500;  
  int closestX = 0;
  int closestY = 0;
  
  
  for (int x = 0; x < video.width; x++ ) {
   for (int y = 0; y < video.height; y++ ) {
    
     int loc = x + y * video.width;
     color currentColor = video.pixels[loc];
     float r1 = red(currentColor);
     float g1 = green(currentColor);
     float b1 = blue(currentColor);
     float r2 = red(colorArma);
     float g2 = green(colorArma);
     float b2 = blue(colorArma);
     float d = dist(r1, g1, b1, r2, g2, b2); 
     
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
   }
  }
  
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
    fill(colorArma);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX, closestY, 16, 16);
  }
}

void mousePressed() {
  //Guardar el color del objeto usado como arma
  int loc = mouseX + mouseY*video.width;
  colorArma = video.pixels[loc];
  println(colorArma);
  //rojo -7723216
}
