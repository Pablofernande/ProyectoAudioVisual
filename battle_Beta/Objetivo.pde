class Objetivo{

 float x, y;
 float size = 40;

 float vy = 2;
 boolean estaDestruido = false;
 

 public Objetivo(){

  reset();
 }

 void dibujar(){
  if(!estaDestruido){ 
     fill(120,220,120);
     strokeWeight(1);
     rect(x,y,size,size);
  }
 }

 void mover(){
   if(y > height){
     estaDestruido=true;
     vidas--;
     reset();
   }
   this.y += vy;
 }
 
 
 void colision(){
   estaDestruido=true;
   reset();
 }
 
 void reset(){
   this.x=random(20,width-40);
   this.y=10;
   estaDestruido=false;
   
 }
}
