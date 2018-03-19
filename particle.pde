class particle extends movable {
  PImage img;//what the image of the particle is
  int time;//what time the particle should appear
  int counter;//used to time how long the particle shows
  int tinter;//used to make particle fade out
  int duration;//how long the particle will exist
  public particle(int x, int y, int time, String name, int duration) {
    super(x, y);//extends movable, so call super() with x and y variables
    img = loadImage(name+".png");//load the image based on name
    this.time = time;//this.time to differentiate class's time and constructors time.
    counter = 0;
    //this.x = rand.nextInt(width);
    // this.y =  rand.nextInt(height);
    tinter = 255;
    this.x -= img.width/2;
    this.y -= img.height/2;
    this.duration = duration;
  }
public particle(int x, int y, int time, String name) {
    super(x, y);
    img = loadImage(name+".png");
    this.time = time;
    counter = 0;
    //this.x = rand.nextInt(width);
    // this.y =  rand.nextInt(height);
    tinter = 255;
    this.x -= img.width/2;
    this.y -= img.height/2;
    this.duration = 15;
  }
  public boolean show() {
    if  (time <= music.position()) {
      counter ++;
      tint(255, tinter);
      image(img, x-counter, y-counter);
      tinter -= duration;
    }
    return(tinter < 0);
  }
}