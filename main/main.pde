import ddf.minim.*;

Minim minim;
AudioPlayer music;

ArrayList<minigame> minigames;
particleManager pm;
int currentGame;
double time = 0;
double words = 0;
PImage img;

void setup() {
  size(640, 360);
  noStroke();
  background(126);
  currentGame = 0;
  minigames = new ArrayList<minigame>();
  minigames.add(new typingTest2(50,150,32)); 
  //Load a soundfile  from the /data folder of the sketch and play it back
  //  file = new SoundFile(this, "D:/SS13/kolly/GAS-GAS-GAS/main/NIGHT OF FIRE.mp3");
 // file.play();
 minim = new Minim(this);
 music = minim.loadFile("NIGHT OF FIRE.mp3");
 music.play();
 
  pm = new particleManager();
  
}

void draw() { 
    background(0);
   minigames.get(currentGame).outputText();
  time += 1/3600.0;
  pm.checkP();

}

void keyPressed() {
  pm.stopWriter();
  int num = minigames.get(currentGame).tryType(key, keyCode);
  if (num == 1)
    words++;
  if (num == 2||keyCode == RIGHT)
    minigames.set(0, new typingTest2(50,150,32));
  println((words/5)/time);    
}
void mousePressed(){
if (mouseButton == LEFT)
    pm.addP(mouseX, mouseY, millis(),"star");
 else
   pm.addP(mouseX,mouseY,millis(),"oh");

}