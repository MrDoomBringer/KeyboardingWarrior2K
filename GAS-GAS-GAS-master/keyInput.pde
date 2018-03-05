int rectWidth;
int checker;
String[] words = {"the", "quick", "brown", "fox"};
String currentWord;
PFont myFont;
int fontSize;

void setup() {
  size(640, 360);
  noStroke();
  background(126);
  rectWidth = width/4;
  checker = 0;
  fontSize = 32;
    

  myFont = createFont("Georgia", fontSize);
  textFont(myFont);
}

void draw() { 
  background(0);
  int num = 0;
  for (int i = 0; i < words.length; i++){
    text(words[i],num,50);
    num += words[i].length()*22;
  }
  
}

void keyPressed() {
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (keyIndex != -1){
    if (currentWord.tryLetter(key))
      tryWord += key;
  }
  if (key == BACKS
  
}
