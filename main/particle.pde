class particle extends movable{
  PImage img;
  int time;
  int counter;
  int tinter;
public particle(int x,int y, int time, String name){
  super(x,y);
  img = loadImage(name+".png");
  this.time = time;
  counter = 0;
  //this.x = rand.nextInt(width);
 // this.y =  rand.nextInt(height);
  tinter = 255;
  this.x -= img.width/2;
  this.y -= img.height/2;
}

public boolean show(){
 if  (time <= millis()){
   counter ++;
    tint(255,tinter);
   image(img, x-counter,y-counter);
  
   tinter -= 5;
 }
 return(tinter < 0);

 
}
}