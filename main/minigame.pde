class minigame extends movable
{
  PFont font;
  int fontSize;
  Random rand;
  public minigame(int x, int y, int fontSize)
 {
   super (x,y);
   this.fontSize = fontSize;
   font = createFont("Consolas", fontSize);
   textFont(font);
   rand = new Random(); 
 }
 public void outputText(){}
 
 public int tryType(char letter, int code){ return 0; }
 
  
}