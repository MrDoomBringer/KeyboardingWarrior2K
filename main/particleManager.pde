PrintWriter output;

class particleManager{
  int time;
  ArrayList<particle> pList = new ArrayList<particle>();
  public particleManager(){
   time = 0;
  output = createWriter("particles.txt");
  }
  public void test(){
    time = millis();
    println(time);
    }
  public void checkP(){
    for (int i = pList.size()-1; i >=0; i--){
      if (pList.get(i).show())
        pList.remove(i);
      
    }
  }
  public void stopWriter(){
  output.flush(); 
  output.close(); 
  exit();
  }
    public void addP(int x, int y, int num, String name){
    pList.add(new particle(x,y,num, name));
    output.println("pList.add(new particle("+x+","+y+","+num+",\""+name+"\"));");
  

}
 }