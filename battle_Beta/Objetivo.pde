class Objetivo{

 float x, y;
 float size = 40;

 float vy = -2;
 float vx;
 boolean estaDestruido = false;
 
 boolean trampa=false;
 
 boolean bonus=false;
 

 public Objetivo(){

  reset();
 }

 void dibujar(){
  if(!estaDestruido){ 
    if(trampa){
     fill(255,0,0);
    }
    else if(bonus){
     fill(0,125,255);
    }
    else{
      fill(120,220,120);
    }
     
     strokeWeight(1);
     rect(x,y,size,size);
  }
 }

 void mover(){
   if(y > height){
      if(!trampa && !bonus){
       vidas--;
     }
     estaDestruido=true;
     reset();
   }
   if(y<=height/8){
      vy=vy*-1;   
   }
   this.y += vy;
   this.x+=vx;
 }
 
 
 void colision(){
   if(trampa){
     vidas--;
   }
   else if(bonus){
     puntuacion+=50;
   }
   else{
     puntuacion+=10;
   }
   estaDestruido=true;
   reset();
 }
 
 void reset(){
   this.x=random(20,width-40);
   this.y=height-10;
   estaDestruido=false;
   trampa=false;
   bonus=false;
   float z=random(9);
   vy=-random(1.5,2.5);
   
   vx=random(0.5,1);
   
   if(x>width/2){
     vx=vx*-1;
   }
   
   
   if(puntuacion>100){
     if(z>=8&& z<9){
       trampa=true;
     }
     if(z>3&&z<3.5){
       bonus=true;
       vy=-5;
     }
     println(z);
   }
   
   
 }
}
