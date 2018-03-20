////////////////////////////////////////////////////////////////////////////////////MADE BY ME////////////////////////////////////////////////////////////////////////////

import java.util.*;//abstraction of moving objects
class movable
{
  int x;//init positions
  int y;
  Random rand;
  public movable(int x, int y) 
  {
    this.x = x;//define positions
    this.y = y;
    rand = new Random();
  }
  public String toString() { 
    return "("+x+", "+y+")";
  }//print out coordinates of object
}