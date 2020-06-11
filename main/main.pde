public static final int WIN = -2;//if you win the game
public static final int LOSE = -1;//if you lose the game
public static final int MENU = 0;//menu screen
public static final int INTRO = 1;//first cutscene
public static final int MAIN = 2;//first battle
public static final int BOSSINTRO1 = 3;//first few seconds of boss cutscene, still shows gameplay so we made a seperate stage for it
public static final int BOSSINTRO2 = 4;//rest of boss cutscene, this one is shows just backgrounds
public static final int BOSSMAIN = 5;//beginning of bossFight. During the first few seconds, the player cant move to allow a neat animation to play, and as such this was created
public static final int BOSSMAIN2 = 6;//second battle
import ddf.minim.*;
Minim minim;
AudioPlayer music;
AudioPlayer musicFX;
imageHandler imgHandler;
car blueCar;
car redCar;
minigame minigame;
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
  minigame = new typingTest(50, 150, 32);  //makes a minigame object, takes key inputs and outputs a result
  blueCar = new car(150, 100, false); //blue car, controlled by the player
  redCar = new car(450, 100, true); //enemy car
  redCar.setOpponent(blueCar); //each car has an opponent variable, cant be used in constructors becaues one will not have been initialized yet
  blueCar.setOpponent(redCar); //ditto
  ///////////////////////setting up music player/////////////////
  minim = new Minim(this);//uses a library called Minim to play music
  music = minim.loadFile("assets/audio/title theme.mp3");//load title theme to be immediatley played
  musicFX = minim.loadFile("assets/audio/buttonFX.wav");//second music object to play multiple things at once
  music.loop(); //set music to loop
  music.play();
}


void draw() { 
  ///////////////////////stage handling/////////////////
  //cutscenes are made by setting backgrounds as per the music's position and the current stage

  if (stage == WIN || stage == LOSE) {//if the game is over, then you should only display a background and nothing else. Having this conditional first ensures this
    background(loadImage("assets/images/endgame"+stage+".png"));
  } else {
    imgHandler.update(stage, redCar, blueCar);//imgHandler.update() calls a variety of things, primarily setting background based on stage and music position, as well as adding particle effects 
    if (fade < 255) {//used for fading out of scenes. While the fade is transpatent (value<255), we...
      fade+=2;//increase fade
      music.setGain(music.getGain()-1);//and lower the current music's volume
      if (fade >=255) {
        if (stage == MENU) {//once the fade variable is >255 (opaque), we change the stage and play a new song
          stage = INTRO;
          music = minim.loadFile("assets/audio/NIGHT OF FIRE.mp3");
        } else if (stage == BOSSINTRO1) {
          music = minim.loadFile("assets/audio/GAS GAS GAAAS.wav");
          imgHandler.counter = 0;//imgHandler.counter is a variable used for outputting cutscenes (explained further in imageHandler.pde), so we need to reset it to zero for new cutscenes
        }
        music.loop();//after setting new music, set it to loop and play it
        music.play();
      }
      fill(0, fade);//fill a screen-sized rectangle with the fade variable to create a transition
      rect(0, 0, width, height);
    }
    if (stage == INTRO && music.position() > 41334) {
      stage = MAIN;//if intro cutscene, and the music has reached a certain point, switch stages
    }
    if (stage == MAIN || stage == BOSSMAIN2) {//these are the two stages where the user is battling an enemy
      minigame.outputText(blueCar);
      if (blueCar.rand.nextInt(100) < 8) 
        direction = -1 * direction;//direction has a 8/100 % chance to change
      if (stage == MAIN) {//during the frist battle, 
        redCar.y-=direction;//the red car moves randomly
        blueCar.y+=1;// and the player car moves downward
        if (blueCar.y > height-10) {//if the bluecar gets too low during the first battle, deal damage to it then push it back forward
          blueCar.damage(20);
          blueCar.y-=180;
        }
      } 
      blueCar.output();//used to dislpay the car's health and stats (correct words and incorrect words)
      redCar.output();//enemy cars have an NPC variable which, if true, will make them not display stats but still display health
      if (blueCar.x <= 5)//bounds. if the player car's x variable gets too big or too small, we push it back 
        blueCar.x = 15;
      if (blueCar.x >= width-imgHandler.playerCarImg.width)
        blueCar.x = width-imgHandler.playerCarImg.width;
    }
    if (stage == MAIN && redCar.health <= 0) {//if you get the red car's health down to zero in the first battle, then
      fade = 0;//set fade to zero, which will make the second conditional in draw() be called and start fading out
      stage = BOSSINTRO1;//set stage to bossintro1
    }

    if (stage == BOSSINTRO1 && fade >=255)//once the screen has faded to black,
      stage = BOSSINTRO2;//go to the next stage (second cutscene)



    else if (stage == BOSSINTRO2 && music.position() > 18300) {//bossIntro cutscene plays until the music reaches a certain point, at which point we...
      stage = BOSSMAIN;//move onto next stage
      imgHandler.update(stage, redCar, blueCar);//update imgHandler to account for new stage
      surface.setSize(450, 800);//change the frame's size to more verticle
      imgHandler.pm.addP(300, height/2, music.position(), "ready", 1);//add a ready particle effect(more details in imageHandler.pde and particleManager.pde)
      redCar.x = -50;//set enemy to near middle top of screen
      redCar.y = -100;
      blueCar.x = width/2;//set player car to bottom middle of screen
      blueCar.y = height-200;
      imgHandler.playerCarImg.resize(100, 0);//make player call smaller
      imgHandler.bgimg = loadImage("assets/images/longRoad1.png");//changes the texture of the road
      imgHandler.bgimg2 = loadImage("assets/images/longRoad2.png");
    }

    if (stage == BOSSMAIN && music.position() >= 25400) {//once BOSS cutscene done (according to music position) move on to the actual fight
      stage = BOSSMAIN2;//change stage
      imgHandler.update(stage, redCar, blueCar);//update iamge
      redCar.x = width/2-imgHandler.enemyCarImg.width/2;//move enemy to center of screen
      redCar.y = 0;//top of screen
      minigame = new wordFall(0, 0, 32);//make a new minigame, the wordFall system
      redCar.setHealth(500, 500);//set boss's health (and initialHealth) to 500
    }
    if (blueCar.health <=0) {//when you lose, switch stage, play a sad song and change surface to fit the image it will show
      stage = LOSE;
      music.pause();
      music = minim.loadFile("assets/audio/sadSong.mp3");
      music.play();
      delay(6000);
      surface.setSize(450, 450);
    } else if (stage == BOSSMAIN2 && redCar.health <=0) {//similear to above
      stage = WIN;
      music.pause();
      music = minim.loadFile("assets/audio/victory.mp3");
      music.play();
      delay(6000);
      surface.setSize(450, 450);
    }
  }
}

void keyPressed() {
  if (stage == MENU && key == ENTER) {//hitting ENTER at the menu
    fade = 0;
    musicFX.play();
  } 
  if (stage == MENU && key == '1') { //debug, goes to first battle
    stage = MAIN;
    music.pause();
    music = minim.loadFile("assets/audio/NIGHT OF FIRE.mp3");
    music.cue(41334);
    music.play();
  }
  if (stage == MENU && key== '2') {//debug, goes to second cutscene
    stage = BOSSINTRO2;
    music.pause();
    music = minim.loadFile("assets/audio/GAS GAS GAAAS.wav");
    music.cue(18400);
    music.play();
    imgHandler.counter = 0;
  } 
  if (stage == BOSSINTRO2 && key== '3') {//debug, goes to second battle
    stage = BOSSMAIN;
    music.pause();
    music = minim.loadFile("assets/audio/GAS GAS GAAAS.wav");
    music.cue(25400);
    music.play();
    imgHandler.counter = 0;
  } else if (stage == MAIN || stage == BOSSMAIN2) {//if battling,
    int num = minigame.tryType(key, keyCode, blueCar);//set a variable to the output of tryType(), variable will return either powerup, correct, incorrect, or noeffect
    if (num == CORRECT || num == POWERUP) {
      blueCar.correct();
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "one");//if correct, at a "+1" particle
      if (blueCar.correct%5==0 && blueCar.streak>0) {
        redCar.damage(blueCar.streak);
        imgHandler.pm.addP(redCar.x+120, redCar.y+120, music.position(), "boom 2");//every 5 correct words, deal damage to the redcar based on the number of correct words youve gotten in a row, then display an explosion particle on the enemy car
      }
    } else if (num == INCORRECT) {
      blueCar.incorrect();
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "minusOne");//similar to above
    } 
    if (stage == MAIN && (minigame.next||keyCode == RIGHT))//debug, right arrow gives you a new sentence to type
      minigame = new typingTest(50, 150, 32);//if all words are exhausted, make a new typing test
  }
}
