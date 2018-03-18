class minigame extends movable
{
  PFont font;
  int fontSize;
  boolean next;
  public minigame(int x, int y, int fontSize)
  {
    super (x, y);
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