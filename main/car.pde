class car extends movable {
  int correct;
  int incorrect;
  boolean npc;
  car opponent;
  float health;
  float initialHealth;
  int streak;
  public car(int x, int y, boolean npc) {
    super(x, y);  
    correct = 0;
    incorrect = 0;
    this.npc = npc;
    health = 100.0;
    initialHealth = health;
    streak = 0;
  }
  public void setOpponent(car opponent){
    this.opponent = opponent;
  }
  public void setHealth(float health, float initialHealth){
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
    fill(255,0,0);
    rect(x,y,20,initialHealth);
    fill(0,255,0);
    rect(x,y+100,20,-1*health);
    fill(255);
  }
  public void damage(int damage){
    health-= damage;
  }
  
  public void correct(){
    streak++;
    correct++;
    if (opponent.initialHealth <=100)
      if (y > 60)
        y-=50;
  }
  public void incorrect(){
    streak = 0;
    incorrect++;
  }
}