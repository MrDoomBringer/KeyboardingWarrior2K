class imageHandler {
  PImage bgimg;
  PImage bgimg2;
  PImage bgMenu;
  PImage bgIntro;
  int bg;
  int fade;
  public particleManager pm;
  public imageHandler() {
    fade = 255;
    bgimg = loadImage("road1.png");
    bgimg2 = loadImage("road2.png");
    bgMenu = loadImage("menu.png");
    bgIntro = loadImage("intro.png");
    bg = 1;

    pm = new particleManager();
    pm.addP(0, 0, 0, "");
  }

  public void update(int time, int stage) {


    if (stage == MENU)
      background(bgMenu);
    else if (stage == INTRO) {
      if (time <= 28600)
        background(bgIntro);
      else if (time <= 28630)
        background(loadImage("roadScene1.png"));
      else if (time <= 28630)
        background(loadImage("roadScene2.png"));
      else if (time <= 30139)
        background(loadImage("roadScene3.png"));
      else if (time <= 31555)
        background(loadImage("roadScene4.png"));
      else if (time <= 33158)
        background(loadImage("roadScene5.png"));
      else if (time <= 34783)//
        background(loadImage("roadScene6.png"));
      else if (time <= 35572)//
        background(loadImage("roadScene7.png"));
      else if (time <= 36362)
        background(loadImage("roadScene8.png"));
      else if (time <= 37151)
        background(loadImage("roadScene9.png"));
      else if (time <= 37941)//
        background(loadImage("roadScene10.png"));
      else if (time <= 38707)//
        background(loadImage("roadScene11.png"));
      else if (time <= 39473)
        background(loadImage("roadScene12.png"));
      else if (time <= 39586)
        background(loadImage("roadScene13.png"));
      else if (time <= 39700)//
        background(loadImage("roadScene14.png"));
      else if (time <= 39800)//
        background(loadImage("roadScene15.png"));
      else if (time <= 39900)
        background(loadImage("roadScene16.png"));
      else if (time <= 40000)
        background(loadImage("roadScene17.png"));
      else if (time <= 40600)//
        background(bgimg);
      else
        background(0);


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
      fade--;
    }
  }
}