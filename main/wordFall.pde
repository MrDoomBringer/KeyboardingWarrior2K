class wordFall extends minigame
{
  PFont font;
  int fontSize;
  boolean next;
  public wordFall(int x, int y, int fontSize)
  {
    super(x, y,fontSize);
    this.fontSize = fontSize;
    font = createFont("Consolas", fontSize);
    textFont(font);
    next = false;
  }
  public void outputText(car playerCar) {
  }

  public int tryType(char letter, int code) { 
    return 0;
  }
}