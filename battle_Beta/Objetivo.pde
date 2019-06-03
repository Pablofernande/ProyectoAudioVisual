class Objetivo{

 float x, y;
 float size = 40;

 float vy = 2;
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
   this.y += vy;
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
   this.y=10;
   estaDestruido=false;
   trampa=false;
   bonus=false;
   float z=random(9);
   if(puntuacion>100){
     if(z>=8&& z<9){
       trampa=true;
     }
     if(z>3&&z<3.5){
       bonus=true;
     }
     println(z);
   }
   
   
 }
}
