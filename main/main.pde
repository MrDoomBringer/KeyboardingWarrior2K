/*
28630
 30139
 31555
 33158
 34783
 36362
 37941
 39473
 //////////////
 28676
 30162
 31625
 33227
 - 34876
 34876
 35201
 35619
 35990
 - 36362
 36710
 37151
 37523
 - 37871
 38266
 38684
 39032
 - 39450
 39775
 40054
 40333
 40611
 40820
 */
public static final int MENU = 0;
public static final int INTRO = 1;
public static final int MAIN = 2;
public static final int BOSSINTRO = 3;
public static final int BOSSMAIN = 3;
import ddf.minim.*;
Minim minim;
AudioPlayer music;
AudioPlayer musicFX;
ArrayList<minigame> minigames;
int currentGame;
double time = 0;
double words = 0;
int stage;
int fade;
imageHandler imgHandler;
car blueCar;
car redCar;
int direction;
void setup() {
  size(800, 450);
  noStroke();
  imgHandler = new imageHandler();
  stage = 0;
  currentGame = 0;
  fade = 256;
  minigames = new ArrayList<minigame>();
  minigames.add(new typingTest2(50, 150, 32)); 

  minim = new Minim(this);
  music = minim.loadFile("title theme.mp3");
  musicFX = minim.loadFile("buttonFX.wav");
  // music.setVolume(100);
  music.loop();
  music.play();
  direction = 1;

  blueCar = new car(150, 100, false, redCar);
  redCar = new car(450, 100, true, blueCar);
}


void draw() { 
  imgHandler.update(music.position(), stage, redCar, blueCar);


  if (fade < 255) {
    fade+=2;
    music.setGain(music.getGain()-1);
    if (fade >=255) {
      stage = INTRO;
      music = minim.loadFile("NIGHT OF FIRE.mp3");
      music.loop();
      music.play();
    }
    fill(0, fade);
    rect(0, 0, width, height);
  }

  if (stage == INTRO && music.position() > 41334) {
    stage = MAIN;
  }
  if (stage == INTRO || stage == MAIN)
    imgHandler.pm.checkP(music.position()); 
  if (stage == MAIN) {
    minigames.get(currentGame).outputText(blueCar);

    if (blueCar.rand.nextInt(100) < 8) direction = -1 * direction;

    redCar.y-=direction;
    blueCar.output();
    redCar.output();
    blueCar.y+=1;
  }
  time += 1/3600.0;
}

void keyPressed() {
  //pm.stopWriter();
  if (stage == MENU && keyCode == ENTER) {
    fade = 0;
    musicFX.play();
  } else if (stage == INTRO && keyCode == ENTER) 
    music.cue(40000);//24276);
  else if (stage == MAIN) {
    if (keyCode == CONTROL)
      music.cue(40000);
    int num = minigames.get(currentGame).tryType(key, keyCode);
    if (num == CORRECT) {
      blueCar.correct();
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "one");
      if (blueCar.correct%5==0 && blueCar.streak>0) {
        redCar.damage(1);
        imgHandler.pm.addP(redCar.x+120, redCar.y+120, music.position(), "boom 2");
      }
    } else if (num == INCORRECT) {
      blueCar.incorrect();
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "minusOne");
    } 
    if (minigames.get(0).next||keyCode == RIGHT)
      minigames.set(0, new typingTest2(50, 150, 32));
    //println((words/5)/time);
  }
}
void mousePressed() {
  System.out.println("("+mouseX+", "+mouseY+")");
  if (mouseButton == LEFT)
    System.out.println(music.position());
  //imgHandler.pm.addP(mouseX, mouseY, music.position(), "star");
  else
    System.out.println(" - "+music.position());
  //imgHandler.pm.addP(mouseX, mouseY, music.position(), "oh");*
}