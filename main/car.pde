////////////////////////////////////////////////////////////////////////////////////MADE BY ME////////////////////////////////////////////////////////////////////////////

class car extends movable {
  int correct;
  int incorrect;
  boolean npc;
  car opponent;
  float health;
  float initialHealth;
  int streak;
  int laser;
  int words;
  double time;
  fallingWord word;
  public car(int x, int y, boolean npc) {
    super(x, y);  
    correct = 0;//num of correct words
    incorrect = 0;//num of incorrect words
    this.npc = npc;
    health = 100.0;
    initialHealth = health;
    streak = 0;//how many words correct youve gotten in a row
    laser = 0;//used to time lasers appearence
    time = 0.0;//used for WPM
    words = 0;//used for WPM
  }
  public void setOpponent(car opponent) {
    this.opponent = opponent;
  }
  public void setHealth(float health, float initialHealth) {
    this.health = health;
    this.initialHealth = initialHealth;
  }
  public void output() {
    time += 1/3600.0;
    if (!npc) {
      text(correct, 0, 32);
      text(incorrect, ((""+correct).length())*32, 32);
      text("WPM = "+(int)(words/(time)), 0, 64);//display words / minutes
    }
    fill(255, 0, 0);
    rect(x, y, 10, initialHealth);
    fill(0, 255, 0);
    if (health > 0)
      rect(x, y+initialHealth, 10, -1*health);
    fill(255);

    if (word != null) {//if we have a word save in variable...
      laser++;//count up laser
      strokeWeight(10);
      stroke(255, 0, 0, 255-laser*10);//make laser transparent as laser variable goes up
      System.out.println(""+x+" "+y+" "+word.x+" "+word.y);//shoot a laser at the word
      line(x, y, word.x, word.y);
      stroke(255);
      strokeWeight(0);

      if (laser > 20) {//if laser >20, then stop the laser
        word = null;
        laser = 0;
      }
    }
  }
  public void damage(int damage) {
    health-= damage;
  }

  public void correct() {
    words++;//used for WPM
    streak++;
    correct++;
    if (opponent.initialHealth <=100)//if enemy is not a boss and i get a word right, then move forward a bit
      if (y > 60)
        y-=50;
  }
  public void incorrect() {
    streak = 0;
    incorrect++;
  }
}