class car extends movable {
  int correct;
  int incorrect;
  boolean npc;
  car opponent;
  float health;
  float initialHealth;
  int streak;
  int laser;
  fallingWord word;
  public car(int x, int y, boolean npc) {
    super(x, y);  
    correct = 0;
    incorrect = 0;
    this.npc = npc;
    health = 100.0;
    initialHealth = health;
    streak = 0;
    laser = 0;
  }
  public void setOpponent(car opponent) {
    this.opponent = opponent;
  }
  public void setHealth(float health, float initialHealth) {
    this.health = health;
    this.initialHealth = initialHealth;
  }
  public void output() {
    if (npc) {
      correct = opponent.correct+5;
      incorrect = opponent.incorrect/2;
      text(correct, 700-((""+correct).length())*32, 32);
      text(incorrect, 700, 32);
    } else {
      text(correct, 0, 32);
      text(incorrect, ((""+correct).length())*32, 32);
    }
    fill(255, 0, 0);
    rect(x, y, 10, initialHealth);
    fill(0, 255, 0);
    if (health > 0)
      rect(x, y+initialHealth, 10, -1*health);
    fill(255);

    if (word != null) {
      laser++;
      strokeWeight(10);
      stroke(255, 0, 0, 255-laser*10);
      System.out.println(""+x+" "+y+" "+word.x+" "+word.y);
      line(x, y, word.x, word.y);
      stroke(255);
      strokeWeight(0);

      if (laser > 20) {
        word = null;
        laser = 0;
      }
    }
  }
  public void damage(int damage) {
    health-= damage;
  }

  public void correct() {
    streak++;
    correct++;
    if (opponent.initialHealth <=100)
      if (y > 60)
        y-=50;
  }
  public void setW(fallingWord w) {
    word = w;
  }
  public void incorrect() {
    streak = 0;
    incorrect++;
  }
}