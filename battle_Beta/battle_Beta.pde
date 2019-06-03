
import processing.video.*;


Capture video;
color colorArma;
Objetivo objetivo;

int closestX = 0;
int closestY = 0;

int vidas=3;

int puntuacion=0;

ArrayList<Objetivo> objetivos = new ArrayList<Objetivo>();

boolean added=false;



void setup() {

  size(640,480);
  
 video = new Capture(this, width, height);
 video.start();
 for(int i=0;i<=-1;i++){

   objetivos.add(new Objetivo());
 }
  
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
 
 pintarVidas();
 
 controlObjetivos();
 
 pintarPuntuacion();

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
   
  }
  
  if (worldRecord < 10) { 
    // Draw a circle at the tracked pixel
    fill(colorArma);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX, closestY, 16, 16);
  }
}


void checkColision(Objetivo objetivo){
  if(closestX>=objetivo.x && closestX<=objetivo.x+objetivo.size){
    if(closestY>=objetivo.y && closestY<=objetivo.y+objetivo.size){
       objetivo.colision();  
       
    }
  }
}

void mousePressed() {
  //Guardar el color del objeto usado como arma
  int loc = -mouseX + mouseY*video.width;
  colorArma = video.pixels[loc];
 
}

void pintarVidas(){
  float gap=25;
  for(int i=1;i<=vidas;i++){
   fill(255,0,0);
   strokeWeight(1);
   ellipse(width-i*gap,height/15,20,20);
 }
}
 
void pintarPuntuacion(){
   fill(255,255,255);
   textSize(20);
   text(puntuacion,30,height/15);
 
}
void controlObjetivos(){
  if(puntuacion%100==0 && added==false){
     objetivos.add(new Objetivo());
     added=true;
  }
  
  if(puntuacion%100!=0){
    added=false;
  }
  
  for (Objetivo objetivo : objetivos) {
   checkColision(objetivo);
   objetivo.dibujar();
   objetivo.mover();
 }
}
