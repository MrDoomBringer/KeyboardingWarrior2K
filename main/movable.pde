class movable
{
  int x;//init positions
  int y;
 public movable(int x, int y) 
 {
   this.x = x;//define positions
   this.y = y;
 }
 public int X(){ return x; }//return x value
 
 public int Y(){ return y; }//return y value
 
 public void cX(int value){ x += value; }//change x value
 
 public void cY(int value){ y += value; }//change y value
 
 public void sX(int value){ x = value; }//set x value
 
 public void sY(int value){ y = value; }//set y value
 
 public String toString(){ return "("+x+", "+y+")"; }//print out coordinates of object
  
}