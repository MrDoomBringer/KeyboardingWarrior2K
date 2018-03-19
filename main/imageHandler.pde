class imageHandler {
  PImage bgimg, bgimg2, bgMenu, bgIntro, enemyCarImg, playerCarImg, fidget1, fidget2, fidget3;
  int bg, fade, counter, bossCounter;
  int[] introTimes ={ 28476, 28576, 28676, 30162, 31625, 33227, 34876, 34876, 35201, 35619, 35990, 36362, 36710, 37151, 37523, 37871, 38266, 38684, 39032, 39450, 39475, 40054, 40333, 40611, 40820, };
  int[] bossTimes={580, 3600, 6700, 9800, 11400, 13000, 15000, 16600, 18200, 19800};
  int[] bossCharge={18200, 23846, 24148, 24520, 24891};

  public particleManager pm;
  public imageHandler() {
    fade = 255;
    bgimg = loadImage("road1.png");
    bgimg2 = loadImage("road2.png");
    bgMenu = loadImage("menu.png");
    bgIntro = loadImage("intro.png");
    enemyCarImg = loadImage("redCar.png");
    playerCarImg = loadImage("blueCar.png");
    fidget1 = loadImage("fidget1.png");
    fidget2 = loadImage("fidget2.png");
    fidget3 = loadImage("fidget3.png");
    bg = 1;
    counter = 0;
    bossCounter = 0;
    pm = new particleManager();
    //pm.addP(0, 0, 0, "");
  }

  public void update(int stage, car enemyCar, car playerCar) {
    tint(255);

    if (stage == MENU)
      background(bgMenu);
    else if (stage == INTRO) {
      if (counter < introTimes.length && introTimes[counter]<=music.position()) {
        background(loadImage("i"+int(counter+1)+"-01.jpg"));
        counter++;
      }
    } else if (stage == BOSSINTRO2 && music.position() < 19800) {
      if (counter < bossTimes.length && bossTimes[counter]<=music.position()) {
        background(loadImage("spinner"+int(counter+1)+".png"));
        counter++;
      }
    } else if (stage == MAIN || stage >= BOSSINTRO2 ) {
      if (bg == 1) {
        background(bgimg);
        bg = 2;
      } else if (bg == 2) {
        background(bgimg2);
        bg = 1;
      }
      if (stage == BOSSMAIN && music.position() < 25300) {
        if (bossCounter < bossCharge.length && bossCharge[bossCounter]<=music.position()) {
          enemyCarImg = loadImage("charge"+int(bossCounter)+".png");
          bossCounter++;
        }
      } else if (stage == BOSSMAIN2) {
        if (bossCounter%3==0)
          enemyCarImg = fidget1;
        else if (bossCounter%3==1)
          enemyCarImg = fidget2;
        else if (bossCounter%3==2)
          enemyCarImg = fidget3;
        bossCounter++;
      }
      image(enemyCarImg, enemyCar.x, enemyCar.y);
      image(playerCarImg, playerCar.x, playerCar.y);
      if (blueCar.streak>0) {
        image(loadImage("fire"+bg+".png"), 0, height-50);
        text("STREAK x "+blueCar.streak, 0, height);
      }
    }
    pm.checkP();

    if (stage == MENU && fade > 0) {
      fill(0, fade);
      rect(0, 0, width, height);
      fade-=2;
    }
  }
}