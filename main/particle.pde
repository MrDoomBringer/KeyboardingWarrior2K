class particle extends movable {
  PImage img;//what the image of the particle is
  int time;//what time the particle should appear
  int counter;//used make position of particle move
  int tinter;//used to make particle fade out
  int duration;//how long the particle will exist
  public particle(int x, int y, int time, String name, int duration) {
    super(x, y);//extends movable, so call super() with x and y variables
    img = loadImage("assets/images/"+name+".png");//load the image based on name
    this.time = time;//time for the particle to appear
    counter = 0;
    tinter = 255;//start opaque
    this.x -= img.width/2;//set x and y to middle of image
    this.y -= img.height/2;
    this.duration = duration;
  }
  public particle(int x, int y, int time, String name) {//same as above, just with a default duration = 15
    super(x, y);
    img = loadImage("assets/images/"+name+".png");
    this.time = time;
    counter = 0;
    tinter = 255;
    this.x -= img.width/2;
    this.y -= img.height/2;
    this.duration = 15;
  }
  public boolean show() {
    if  (time <= music.position()) {//if the time to appear is less than the music's current position, then we should display it
      counter ++;//counter increases
      tint(255, tinter);//tint according to value of titer
      image(img, x-counter, y-counter);//counter variable makes the particle move up and to the left as it disappears
      tinter -= duration;//larger numbers make the particle exist shorter
    }
    return(tinter < 0);//once tinter < 0, will get deleted (check particleManager.pde for more info)
  }
}
