int rectWidth;
int checker;
ArrayList<word> words = new wordGroup("a the quick brown fox a").getWordGroup();
String currentWord;
PFont myFont;
int fontSize;
int cursorIndex;

void setup() {
  size(640, 360);
  noStroke();
  background(126);
  rectWidth = width/4;
  checker = 0;
  fontSize = 32;
  cursorIndex = 0;

  myFont = createFont("Consolas", fontSize);
  textFont(myFont);
}

void draw() { 
  background(0);
  int shift = 0;
  int counter = 0;
  int correctPosition = 0;
  for (int i = 0; i < words.size(); i++){
    for (int j = 0; j < words.get(i).getLetters().size(); j++){
      if (counter == cursorIndex)
        fill(255,0,0);
      else
        fill(255);
      text(words.get(i).charAt(j),shift,50);
      shift += fontSize/2;
      counter ++;
    }
    shift += fontSize/2;
  }
  
}

void keyPressed() {
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  word currentWord = new word("hello");
  String tryWord = "asd";
  int index = 0;
  if (keyIndex != -1){
    if (currentWord.tryLetter(key,index))
      tryWord += key;
  }
  if (key == BACKSPACE){
  tryWord = tryWord.substring(0,tryWord.length()-1);
  wordGroup wordGroup = new wordGroup("a the quick brown fox a");
  System.out.print(wordGroup.getWordGroup());
  }
  if (key == ' '){
    cursorIndex++;
  }
}