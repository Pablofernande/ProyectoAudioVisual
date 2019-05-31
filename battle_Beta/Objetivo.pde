class Objetivo{
 float x, y;
 float diametro = 40;

 float vy = 5;
 boolean estaColisionando = false;

 public Objetivo(float x, float y){
 this.x = x;
 this.y = y;
 }

 void dibujar(){
 fill(120,220,120);
 strokeWeight(1);
 rect(x,y,diametro,diametro);
 }

 void mover(){
 if( y-diametro/2 < 0){
   //Fail
 }
 this.y += vy;
 }
}
