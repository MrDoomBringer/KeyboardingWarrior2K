class imageHandler {
  PImage bgimg;
  PImage bgimg2;
  PImage bgMenu;
  PImage bgIntro;
  PImage enemyCarImg;
  PImage playerCarImg;
  int bg;
  int fade;
  int counter;
  int[] times ={ 
    28476, 
    28576, 
    28676, 
    30162, //
    31625, //
    33227, //
    34876, //
    34876, 
    35201, 
    35619, 
    35990, 
    36362, //
    36710, 
    37151, 
    37523, 
    37871, //
    38266, 
    38684, 
    39032, 
    39450, //
    39475, 
    40054, 
    40333, 
    40611, 
    40820, 
  };


  public particleManager pm;
  public imageHandler() {
    fade = 255;
    bgimg = loadImage("road1.png");
    bgimg2 = loadImage("road2.png");
    bgMenu = loadImage("menu.png");
    bgIntro = loadImage("intro.png");
    enemyCarImg = loadImage("redCar.png");
    playerCarImg = loadImage("blueCar.png");
    bg = 1;
    counter = 0;
    pm = new particleManager();
    //pm.addP(0, 0, 0, "");
  }

  public void update(int time, int stage, car enemyCar, car playerCar) {
    tint(255);

    if (stage == MENU)
      background(bgMenu);


    else if (stage == INTRO) 
    {

      if (counter < times.length && times[counter]<=time) {
        background(loadImage("i"+int(counter+1)+"-01.jpg"));
        counter++;
      }
      pm.checkP(time);
    } else {
      if (bg == 1) {
        background(bgimg);
        bg = 2;
      } else if (bg == 2) {
        background(bgimg2);
        bg = 1;
      }
      image(enemyCarImg, enemyCar.x, enemyCar.y);
      image(playerCarImg, playerCar.x, playerCar.y);
      if (blueCar.streak>0) {
        image(loadImage("fire"+bg+".png"), 0, 398);
        text("STREAK x "+blueCar.streak, 0, 450);
      }
    }
    if (stage == MENU && fade > 0) {
      fill(0, fade);
      rect(0, 0, width, height);
      fade-=2;
    }
  }
}