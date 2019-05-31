
import processing.video.*;

Capture video;
color colorArma;
Objetivo objetivo;

int closestX = 0;
int closestY = 0;

void setup() {
  size(640, 480);
  
 video = new Capture(this, 640, 480);
 video.start();
 
 float xO=random(20,600);
 float yO=10;
 objetivo=new Objetivo(xO,yO);
  
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
 objetivo.dibujar();
 objetivo.mover();

}
void escanearPixeles(){
  float worldRecord=500;  
  
  
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
        closestX = abs(x-video.width);
        closestY = y;
      }
   }
    println( closestX, closestY);
  }
  
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
    fill(colorArma);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX, closestY, 16, 16);
  }
}


void checkColision(){

}

void mousePressed() {
  //Guardar el color del objeto usado como arma
  int loc = -mouseX + mouseY*video.width;
  colorArma = video.pixels[loc];
 
  //rojo -7723216
}
