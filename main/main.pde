/*
28630
30139
31555
33158
34783
36362
37941
39473
*/
public static final int MENU = 0;
public static final int INTRO = 1;
public static final int MAIN = 2;
import ddf.minim.*;
Minim minim;
AudioPlayer music;

ArrayList<minigame> minigames;
int currentGame;
double time = 0;
double words = 0;
int stage;
int fade;
imageHandler imgHandler;

void setup() {
  size(800, 450);
  noStroke();
  imgHandler = new imageHandler();
  stage = 0;
  currentGame = 0;
  fade = 256;
  minigames = new ArrayList<minigame>();
  minigames.add(new typingTest2(50, 150, 32)); 
  //Load a soundfile  from the /data folder of the sketch and play it back
  //  file = new SoundFile(this, "D:/SS13/kolly/GAS-GAS-GAS/main/NIGHT OF FIRE.mp3");
  // file.play();
  minim = new Minim(this);
  music = minim.loadFile("title theme.mp3");
  // music.setVolume(100);
  music.loop();
  music.play();
}

void draw() { 
    imgHandler.update(music.position(), stage);
  if (fade < 255) {
    fade++;
    music.setGain(music.getGain()-1);
    if (fade >=255) {
      stage = INTRO;
      music.pause();
      music = minim.loadFile("NIGHT OF FIRE.mp3");
      music.loop();
      music.play();
    }
      fill(0, fade);
  rect(0, 0, width, height);
  }

  if (stage == INTRO && music.position() > 41334)
    stage = MAIN;
  if (stage == INTRO || stage == MAIN)
    imgHandler.pm.checkP(music.position()); 
  if (stage == MAIN)
    minigames.get(currentGame).outputText();




  time += 1/3600.0;
}

void keyPressed() {
  //pm.stopWriter();
  if (stage == MENU && keyCode == ENTER) 
    fade = 0;
  else {
    if (keyCode == CONTROL)
      music.cue(40000);
    int num = minigames.get(currentGame).tryType(key, keyCode);
    if (num == 1)
      words++;
    if (num == 2||keyCode == RIGHT)
      minigames.set(0, new typingTest2(50, 150, 32));
    //println((words/5)/time);
  }
}
void mousePressed() {
  System.out.println(music.position());
  /*if (mouseButton == LEFT)
   imgHandler.pm.addP(mouseX, mouseY, music.position(), "star");
   else
   imgHandler.pm.addP(mouseX, mouseY, music.position(), "oh");*/
}