class wordFall extends minigame
{
  PFont font;
  int fontSize;
  boolean next;
  ArrayList<fallingWord> words;
  String currentWord;
  public wordFall(int x, int y, int fontSize)
  {
    super(x, y,fontSize);
    this.fontSize = fontSize;
    font = createFont("Consolas", fontSize);
    textFont(font);
    next = false;
    words = new ArrayList<fallingWord>();
    currentWord = "";
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"hello"));
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"asdf"));
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"boy"));
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"yo"));
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"moe"));
    words.add(new fallingWord(rand.nextInt(width-20)+20,0,"ree"));
    
  }
  public void outputText(car playerCar) {
    text(currentWord,playerCar.x,playerCar.y);
    for (fallingWord w : words){
      fill(255,255,255);
      text(w.word,w.x,w.y);
      w.y++;
    }
  }

   public int tryType(char letter, int code) {
    if (code == SHIFT) return NOEFFECT;
    else if (code == BACKSPACE) {
      if (currentWord.length() > 0)
        currentWord = currentWord.substring(0, currentWord.length()-1);  
      return NOEFFECT;
    } else if (letter == ' ' || letter == ';') {
      for (fallingWord w : words)
        if (w.check(currentWord)){
          imgHandler.pm.addP(w.x,w.y,music.position(),"nice");
          words.remove(w);
          currentWord = "";
          return CORRECT;
        }
        imgHandler.pm.addP(blueCar.x,blueCar.y,music.position(),"wrong");
        currentWord = "";
        return NOEFFECT;
        
    }
    currentWord += Character.toString(letter);
    return NOEFFECT;
  }
}