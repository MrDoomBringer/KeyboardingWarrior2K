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
public static final int BOSSINTRO1 = 3;
public static final int BOSSINTRO2 = 4;
public static final int BOSSMAIN = 5;
public static final int BOSSMAIN2 = 6;
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
  surface.setResizable(true);
  surface.setSize(800, 450);
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

  blueCar = new car(150, 100, false);
  redCar = new car(450, 100, true);
  redCar.setOpponent(blueCar);
  blueCar.setOpponent(redCar);
}


void draw() { 
  imgHandler.update(stage, redCar, blueCar);

  if (fade < 255) {
    fade+=2;
    music.setGain(music.getGain()-1);
    if (fade >=255) {
      if (stage == MENU) {
        stage = INTRO;
        music = minim.loadFile("NIGHT OF FIRE.mp3");
      } else if (stage == BOSSINTRO1) {
        music = minim.loadFile("GAS GAS GAAAS.wav");
        imgHandler.counter = 0;
      }

      music.loop();
      music.play();
    }
    fill(0, fade);
    rect(0, 0, width, height);
  }

  if (stage == INTRO && music.position() > 41334) {
    stage = MAIN;
  }
  //if (stage == INTRO || stage == MAIN || stage == BOSSMAIN2)
  //imgHandler.pm.checkP(); 
  if (stage == MAIN || stage == BOSSMAIN2) {
    minigames.get(currentGame).outputText(blueCar);
    if (blueCar.rand.nextInt(100) < 8) 
      direction = -1 * direction;
    if (stage == MAIN) {
      redCar.y-=direction;
      blueCar.y+=1;
    } else if (stage == BOSSMAIN2) {
      blueCar.x+=direction*10;
    }
    blueCar.output();
    redCar.output();
    if (blueCar.x <= 5)
      blueCar.x = 15;
    if (blueCar.x >= width-imgHandler.playerCarImg.width)
      blueCar.x = width-imgHandler.playerCarImg.width;
  }
  if (stage == MAIN && redCar.health <= 0) {
    fade = 0;
    stage = BOSSINTRO1;
  }

  if (stage == BOSSINTRO1 && fade >=255)
    stage = BOSSINTRO2;



  else if (stage == BOSSINTRO2 && music.position() > 18300) {
    stage = BOSSMAIN;
    imgHandler.update(stage, redCar, blueCar);
    surface.setSize(450, 800);
    redCar.x = -50;//width/2-imgHandler.enemyCarImg.width/2;
    redCar.y = -100;
    blueCar.x = width/2;
    blueCar.y = height-200;
    imgHandler.playerCarImg.resize(100, 0);
    imgHandler.bgimg = loadImage("longRoad1.png");
    imgHandler.bgimg2 = loadImage("longRoad2.png");
  }

  if (stage == BOSSMAIN && music.position() >= 25400) {
    stage = BOSSMAIN2;
    imgHandler.update(stage, redCar, blueCar);
    redCar.x = width/2-imgHandler.enemyCarImg.width/2;
    redCar.y = 0;
    minigames.set(0, new wordFall(0, 0, 32));
    redCar.setHealth(500, 500);
  }
  time += 1/3600.0;
}

void keyPressed() {
  //pm.stopWriter();
  if ( key == ENTER) {
    fade = 0;
    musicFX.play();
  } 
  if (key == '1') { 
    stage = MAIN;
    music.pause();
    music = minim.loadFile("NIGHT OF FIRE.mp3");
    music.cue(41334);
    music.play();
  }
  if (key== '2') {
    stage = BOSSINTRO2;
    music.pause();
    music = minim.loadFile("GAS GAS GAAAS.wav");
    music.cue(18400);
    music.play();
    imgHandler.counter = 0;
  } 
  if (key== '3') {
    stage = BOSSMAIN;
    music.pause();
    music = minim.loadFile("GAS GAS GAAAS.wav");
    music.cue(25400);
    music.play();
    imgHandler.counter = 0;
  } else if (stage == MAIN || stage == BOSSMAIN2) {
    int num = minigames.get(currentGame).tryType(key, keyCode);
    if (num == CORRECT || num == POWERUP) {        //remove this distinction
      blueCar.correct();
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "one");
      if (blueCar.correct%5==0 && blueCar.streak>0) {
        redCar.damage(blueCar.streak);
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
  System.out.println("("+mouseX+", "+mouseY+")"+mouseButton);
  if (mouseButton == LEFT)
    System.out.println(music.position());
  //imgHandler.pm.addP(mouseX, mouseY, music.position(), "star");
  else
    System.out.println(" - "+music.position());
  //imgHandler.pm.addP(mouseX, mouseY, music.position(), "oh");*
}