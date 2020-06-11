////////////////////////////////////////////////////////////////////////////////////MADE BY ME////////////////////////////////////////////////////////////////////////////

class imageHandler {
  PImage bgimg, bgimg2, enemyCarImg, playerCarImg, fidget1, fidget2, fidget3;
  int bg, fade, counter, bossCounter;
  int[] introTimes ={3854, 5363, 6176, 6942, 8428, 10031, 11609, 13119, 14698, 15534, 16200, 17763, 18529, 18622, 19435, 22407, 23521, 24636, 25495, 27097, 27376, 27678, 27956, 28305, 
    28476, 28576, 28676, 30162, 31625, 33227, 34876, 34876, 35201, 35619, 35990, 36362, 36710, 37151, 37523, 37871, 38266, 38684, 39032, 39450, 39475, 40054, 40333, 40611, 40820, };
  int[] bossTimes={580, 3600, 6700, 9800, 11400, 13000, 15000, 16600};
  int[] bossCharge={ 18000, 23846, 24148, 24520, 24891};

  public particleManager pm;
  public imageHandler() {//HOW IT WORKS: we have an array for each cutscene full of numbers representing when the different images shoudld show up. Once a cutscene's time to appear happens,
    //the algorithm checks to see if the music's position is greater than the position in the array (according to index), and if it is, it displays the relevent picture, then increases index by one
    fade = 255;//another fader, used for the very start of program
    bgimg = loadImage("assets/images/road1.png");//if images are used a lot (eg for things that are drawn constantly), we create a variable for them. Otherwise, we just load them as needed
    bgimg2 = loadImage("assets/images/road2.png");
    enemyCarImg = loadImage("assets/images/redCar.png");
    playerCarImg = loadImage("assets/images/blueCar.png");
    fidget1 = loadImage("assets/images/fidget1.png");
    fidget2 = loadImage("assets/images/fidget2.png");
    fidget3 = loadImage("assets/images/fidget3.png");
    bg = 1;//alternator used for road moving quickly
    counter = 0;//used to count through cutscenes
    bossCounter = 0;
    pm = new particleManager();
  }

  public void update(int stage, car enemyCar, car playerCar) {
    tint(255);

    if (stage == MENU)//display backgrounds according to stage
      background(loadImage("assets/images/menu.png"));
    else if (stage == INTRO) {
      if (counter < introTimes.length && introTimes[counter]<=music.position()) {//INTRO cutscene. Runs until the index of the intro cutscene array goes out of bounds
        if (music.position() < 28476)//if position of music is less than a certain point, display one type of file
          background(loadImage("assets/images/introCutscene"+int(counter+1)+".png"));//counter+1 because files start at "introCutscene1" instead of "introCutscene0"
        else//once it reaches past that point, show these other pictures
          background(loadImage("assets/images/i"+int(counter-23)+"-01.jpg"));//counter-23 to account for the fact that the files are named starting at "1", but the counter is already at 24 at this point
        counter++;
        if (counter == introTimes.length-8)//display "ready" particle at a certain point
          pm.addP(300, height/2, music.position(), "ready", 1);
      }
    } else if (stage == BOSSINTRO2 && music.position() < 21000) {//similear process as above, except for second cutscene before the second battle
      if (counter < bossTimes.length && bossTimes[counter]<=music.position()) {
        background(loadImage("assets/images/spinner"+int(counter+1)+".png"));
        counter++;
      } else if (counter >= bossTimes.length) {
        if (counter%6==0)
          background(loadImage("assets/images/spinner9.png"));//alternate between two images
        else if (counter%6 == 3)
          background(loadImage("assets/images/spinner8.png"));
        counter++;
      }
    } else if (stage == MAIN || stage >= BOSSINTRO2 ) {//stage >= BOSSINTRO2 includes every stage past BOSSINTRO2
      if (bg == 1) {
        background(bgimg);//display the road going by underneath during the two battle scenes
        bg = 2;
      } else if (bg == 2) {
        background(bgimg2);
        bg = 1;
      }
      if (stage == BOSSMAIN && music.position() < 25300) {
        if (bossCounter < bossCharge.length && bossCharge[bossCounter]<=music.position()) {
          enemyCarImg = loadImage("assets/images/charge"+int(bossCounter)+".png");//charging-up animation for the fidget-spinner enemy during a certain part of the BOSSMAIN stage
          bossCounter++;
        }
      } else if (stage == BOSSMAIN2) {
        if (bossCounter%3==0)//if fighting the boss, display a spinning fidget spinner
          enemyCarImg = fidget1;
        else if (bossCounter%3==1)
          enemyCarImg = fidget2;
        else if (bossCounter%3==2)
          enemyCarImg = fidget3;
        bossCounter++;
      }
      image(enemyCarImg, enemyCar.x, enemyCar.y);//display images for cars
      image(playerCarImg, playerCar.x, playerCar.y);
      if (blueCar.streak>0) {
        image(loadImage("assets/images/fire"+bg+".png"), 0, height-50);//if your "streak" stat > 0, display streak with a cool image (animated using the bg variable) behind it
        text("STREAK x "+blueCar.streak, 0, height);
      }
    }
    pm.checkP();//check for any particles

    if (stage == MENU && fade > 0) {//fade for the beginning of the game
      fill(0, fade);
      rect(0, 0, width, height);
      fade-=2;
    }
  }
}
