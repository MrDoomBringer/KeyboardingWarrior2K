ArrayList<minigame> minigames;
int currentGame;
void setup() {
  size(640, 360);
  noStroke();
  background(126);
  currentGame = 0;
  minigames = new ArrayList<minigame>();
  minigames.add(new typingTest(5,5,32));
}

void draw() { 
  background(0);
  minigames.get(currentGame).outputText();
}

void keyPressed() {
  minigames.get(currentGame).tryType(key);
}