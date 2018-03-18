PrintWriter output;

class particleManager {
  int time;
  ArrayList<particle> pList = new ArrayList<particle>();
  public particleManager() {
    time = 0;
    output = createWriter("particles.txt");
  }
  public void test() {
    time = millis();
    println(time);
  }
  public void checkP(int position) {
    for (int i = pList.size()-1; i >=0; i--) {
      if (pList.get(i).show(position))
        pList.remove(i);
    }
  }
  public void stopWriter() {
    output.flush(); 
    output.close(); 
    exit();
  }
  public void addP(int x, int y, int num, String name) {
    pList.add(new particle(x,y,num, name));
    //output.println("pList.add(new particle("+x+","+y+","+num+",\""+name+"\"));");
/*
    pList.add(new particle(575, 148, 4351, "star"));
    pList.add(new particle(217, 106, 5754, "star"));
    pList.add(new particle(521, 256, 6595, "star"));
    pList.add(new particle(80, 221, 7347, "star"));
    pList.add(new particle(541, 203, 10532, "star"));
    pList.add(new particle(200, 55, 12017, "star"));
    pList.add(new particle(547, 69, 12820, "star"));
    pList.add(new particle(358, 240, 16689, "star"));
    pList.add(new particle(510, 127, 18224, "star"));
    pList.add(new particle(165, 63, 19010, "star"));
    pList.add(new particle(354, 202, 19814, "star"));
    pList.add(new particle(161, 255, 22934, "star"));
    pList.add(new particle(431, 63, 24454, "star"));
    pList.add(new particle(582, 279, 25207, "star"));
    pList.add(new particle(292, 126, 30593, "star"));
    pList.add(new particle(524, 201, 32062, "star"));
    pList.add(new particle(93, 158, 33596, "star"));
    pList.add(new particle(406, 109, 36864, "star"));
    pList.add(new particle(355, 223, 38366, "star"));
    pList.add(new particle(487, 109, 39917, "star"));

    //oh
    pList.add(new particle(584, 33, 7491, "oh"));
    pList.add(new particle(507, 49, 7761, "oh"));
    pList.add(new particle(345, 47, 8146, "oh"));
    pList.add(new particle(134, 40, 8850, "oh"));
    pList.add(new particle(251, 42, 9085, "oh"));
    pList.add(new particle(460, 42, 9398, "oh"));
    //pList.add(new particle(530,62,10489,"oh"));
    pList.add(new particle(531, 62, 13596, "oh"));
    pList.add(new particle(416, 65, 13956, "oh"));
    pList.add(new particle(215, 50, 14386, "oh"));
    pList.add(new particle(282, 53, 15032, "oh"));
    pList.add(new particle(377, 54, 15293, "oh"));
    pList.add(new particle(485, 64, 15614, "oh"));
    pList.add(new particle(407, 67, 16035, "oh"));
    pList.add(new particle(224, 62, 16621, "oh"));
    pList.add(new particle(228, 62, 17014, "oh"));
    pList.add(new particle(249, 64, 17392, "oh"));
    pList.add(new particle(307, 63, 17792, "oh"));
    pList.add(new particle(345, 63, 18170, "oh"));
    pList.add(new particle(393, 63, 18578, "oh"));
    pList.add(new particle(448, 63, 18983, "oh"));
    pList.add(new particle(502, 58, 19376, "oh"));
    pList.add(new particle(53, 35, 23013, "oh"));
    pList.add(new particle(82, 34, 23306, "oh"));
    pList.add(new particle(151, 32, 23693, "oh"));
    pList.add(new particle(191, 44, 24040, "oh"));
    pList.add(new particle(266, 55, 24452, "oh"));
    pList.add(new particle(362, 81, 24845, "oh"));
    pList.add(new particle(442, 84, 25222, "oh"));
    pList.add(new particle(549, 95, 25619, "oh"));*/
  }
}