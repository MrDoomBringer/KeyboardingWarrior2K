class minigame extends movable
{
  PFont font;
  int fontSize;

  public minigame(int x, int y, int fontSize)
 {
   super (x,y);
   this.fontSize = fontSize;
   font = createFont("Consolas", fontSize);
   textFont(font);
 }
 public void outputText(){}
 
 public int tryType(char letter, int code){ return 0; }
 
  
}