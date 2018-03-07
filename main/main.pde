ArrayList<minigame> minigames;
int currentGame;
double time = 0;
double words = 0;
double wpm = 0;
double per5 = 0; 
void setup() {
  size(640, 360);
  noStroke();
  background(126);
  currentGame = 0;
  minigames = new ArrayList<minigame>();
  minigames.add(new typingTest(50,150,32));
}

void draw() { 
  background(0);
  minigames.get(currentGame).outputText();
  time+= 1/3600.0;
}

void keyPressed() {
  words++;
  int num = minigames.get(currentGame).tryType(key);
    if (num == 2)
      minigames.set(0, new typingTest(50,150,32));
    //if (num==1 && key==' ')
    //  words++;
    wpm = (words/5)/time;
    //wpm = words/minute();
    println(wpm);
    

  
  
    
}