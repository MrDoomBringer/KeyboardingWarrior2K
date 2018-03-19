public static final int WIN = -2;
public static final int LOSE = -1;
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
imageHandler imgHandler;
car blueCar;
car redCar;
minigame minigame;
double time = 0;
double words = 0;
int stage;
int fade;
int direction;

void setup() {
  ///////////////////////setting up frame properties/////////////////
  noStroke();
  surface.setResizable(true);
  surface.setSize(800, 450);
  ///////////////////////setting up minigame properties/////////////////
  imgHandler = new imageHandler();//create an image handler, used to manage particle effects such as explosions!
  stage = 0; //stage variable, used to determine which point in the game the user is
  fade = 256; //used to fade out of menu screen
  direction = 1; //changes the direction the red car moves
  minigame = new typingTest2(50, 150, 32);  //makes a minigame object, takes key inputs and outputs a result
  blueCar = new car(150, 100, false); //blue car, controlled by the player
  redCar = new car(450, 100, true); //enemy car
  redCar.setOpponent(blueCar); //each car has an opponent variable, cant be used in constructors becaues one will not have been initialized yet
  blueCar.setOpponent(redCar); //ditto
  ///////////////////////setting up music player/////////////////
  minim = new Minim(this);//uses a library called Minim to play music
  music = minim.loadFile("title theme.mp3");//load title theme to be immediatley played
  musicFX = minim.loadFile("buttonFX.wav");//second music object to play multiple things at once
  music.loop(); //set music to loop
  music.play(); 
}


void draw() { 
  if (stage == WIN || stage == LOSE) {
    background(loadImage("endgame"+stage+".png"));
  } else {
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
    if (stage == MAIN || stage == BOSSMAIN2) {
      minigame.outputText(blueCar);
      if (blueCar.rand.nextInt(100) < 8) 
        direction = -1 * direction;
      if (stage == MAIN) {
        redCar.y-=direction;
        blueCar.y+=1;
        if (blueCar.y > height-10) {
          blueCar.damage(20);
          blueCar.y-=180;
        }
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
      imgHandler.pm.addP(300, height/2, music.position(), "ready", 1);
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
      minigame = new wordFall(0, 0, 32);
      redCar.setHealth(500, 500);
    }
    time += 1/3600.0;
    if (blueCar.health <=0) {
      stage = LOSE;
      music.pause();
      music = minim.loadFile("sadSong.mp3");
      music.play();
      delay(6000);
      surface.setSize(450, 450);
    } else if (stage == BOSSMAIN2 && redCar.health <=0) {
      stage = WIN;
      music.pause();
      music = minim.loadFile("victory.mp3");
      music.play();
      delay(6000);
      surface.setSize(450, 450);
    }
  }
}

void keyPressed() {
  //pm.stopWriter();
  if (stage == MENU && key == ENTER) {
    fade = 0;
    musicFX.play();
  } 
  if (stage == MENU && key == '1') { 
    stage = MAIN;
    music.pause();
    music = minim.loadFile("NIGHT OF FIRE.mp3");
    music.cue(41334);
    music.play();
  }
  if (stage == MENU && key== '2') {
    stage = BOSSINTRO2;
    music.pause();
    music = minim.loadFile("GAS GAS GAAAS.wav");
    music.cue(18400);
    music.play();
    imgHandler.counter = 0;
  } 
  if (stage == BOSSINTRO2 && key== '3') {
    stage = BOSSMAIN;
    music.pause();
    music = minim.loadFile("GAS GAS GAAAS.wav");
    music.cue(25400);
    music.play();
    imgHandler.counter = 0;
  } else if (stage == MAIN || stage == BOSSMAIN2) {
    int num = minigame.tryType(key, keyCode, blueCar);
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
    if (minigame.next||keyCode == RIGHT)
      minigame = new typingTest2(50, 150, 32);
    //println((words/5)/time);
  }
}
