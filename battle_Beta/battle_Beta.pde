
import processing.video.*;
import ddf.minim.*;

Capture video;
color colorArma;
Objetivo objetivo;

int closestX = 0;
int closestY = 0;

int vidas=3;

int puntuacion=0;

int count=3;

ArrayList<Objetivo> objetivos = new ArrayList<Objetivo>();

boolean added=false;

boolean inicio,cuentaAtras=false,detectandoArma=true,gameMusicOn=false;
PImage naveNorm,bomba,Medalla,corazon;

PImage portada1,portada2,portada3;

PFont font;


Minim minim;

AudioSample countSound;
AudioSample explosion;
AudioSample loseSound;
AudioSample lossingLive;
AudioSample prizeSound;
AudioSample destroyShip;
AudioSample gainLive;

AudioPlayer musicaFondo;
AudioPlayer musicaFondo2;

void setup() {
  
  minim=new Minim(this);
  
  countSound=minim.loadSample("sounds/countDown.wav");
  explosion=minim.loadSample("sounds/Explosion.wav");
  loseSound=minim.loadSample("sounds/lose.wav");
  lossingLive=minim.loadSample("sounds/LossingLive.wav");
  prizeSound=minim.loadSample("sounds/Prize.wav");
  destroyShip=minim.loadSample("sounds/DestroyElement.wav");
  gainLive=minim.loadSample("sounds/live.mp3");
  
  musicaFondo=minim.loadFile("sounds/Song.mp3");
  musicaFondo2=minim.loadFile("sounds/Song2.mp3");
  
  musicaFondo.loop();
  

  
  inicio=true;
  
  naveNorm = loadImage("img/NaveStela.png");
  bomba = loadImage("img/bomb.png");
  Medalla = loadImage("img/Medalla.png");
  corazon = loadImage("img/corazon.png");
  
  portada1 = loadImage("img/Portada1.jpg");
  portada2 = loadImage("img/Portada2.jpg");
  portada3 = loadImage("img/Portada3.jpg");
  
  font = createFont("Arial Bold", 35);
  
  //Resluciones:
  //640,480
  //1280,720
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
  
  if(cuentaAtras){
        
      if(count>=0){
        image(portada3,0,0,width,height);
        textFont(font);
        textSize(30);
        text("El Juego Comenzara en:",width/10*2, height/10*4);
        fill(255,255,255);
        textFont(font);
        textSize(60);
        text(count,width/2, height/10*6);
        fill(255,255,255);
        countSound.trigger();
        if(count!=3){
          countSound.trigger();
          delay(2000);
        }
        
        count--;
    }
    
    else{
      
      cuentaAtras=false;
      count=3;
      musicaFondo2.loop();
    }
    
    
  }
  
  
  else{
  
    if(inicio){
      image(portada1,0,0,width,height);
      fill(255,255,255);
      textFont(font);
      textSize(35);
      text("Pulsa 'J' para\nIniciar el Juego",width/10*2, height/10*5);
       
     
      
    }
    
    else if(detectandoArma){
     pushMatrix();
     scale(-1, 1);
     video.loadPixels();
     image(video, -video.width, 0);
     popMatrix();
     escanearPixeles();
     fill(255,255,255);
     textFont(font);
     textSize(20);
     text("Selecciona con el ratón el arma que vayas ha usar",20, height-20);

   }
  
   else if(vidas<=0){
      
      if(!gameMusicOn){
        musicaFondo2.pause(); 
        musicaFondo.play();
        gameMusicOn=true;
        loseSound.trigger();
      }
     
      image(portada2,0,0,width,height);
      textFont(font);
      textSize(30);
      text("Puntuación Final: "+puntuacion,width/10*1, height/10*6);
      textFont(font); 
      textSize(20);
      text("Pulsa 'G' para reiniciar el juego",width/10*1, height/10*8);
      fill(255,255,255);
    }
    
    else{
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
 }
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
 if(!inicio){
  //Guardar el color del objeto usado como arma
  int loc = -mouseX + mouseY*video.width;
  colorArma = video.pixels[loc];
    cuentaAtras=true;
    detectandoArma=false;
     musicaFondo.pause();
   
  }
  
 
 
}

void keyPressed(){
  if(key=='j'){
    inicio=false;
   
    
  }
  
  if(key=='g'){
    cuentaAtras=true;
    resetGame();
    musicaFondo.pause();
  }

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
   textFont(font);
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

void resetGame(){
  vidas=3;
  puntuacion=0;
  objetivos = new ArrayList<Objetivo>();
  added=false;
  gameMusicOn=false;
  
}
