class imageHandler {
  PImage bgimg;
  PImage bgimg2;
  PImage bgMenu;
  PImage bgIntro;
  int bg;
  int fade;
  int counter;
  int[] times ={ 
    28276, 
    28476, 
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
    39775, 
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
    bg = 1;
    counter = 0;
    pm = new particleManager();
    pm.addP(0, 0, 0, "");
  }

  public void update(int time, int stage) {


    if (stage == MENU)
      background(bgMenu);
    else if (stage == INTRO) 
    {

      if (times[counter]<=time && counter < times.length) {
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
    }

    if (stage == MENU && fade > 0) {
      fill(0, fade);
      rect(0, 0, width, height);
      fade-=2;
    }
  }
}