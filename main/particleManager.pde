////////////////////////////////////////////////////////////////////////////////////MADE BY PARTNER////////////////////////////////////////////////////////////////////////////

class particleManager {//particle manager. has an arrayList of particles (see particle.pde)
  ArrayList<particle> pList = new ArrayList<particle>();
  public particleManager() {
  }
  public void checkP() {//go through each particle. If they show up, then remove them.
    for (int i = pList.size()-1; i >=0; i--) {
      if (pList.get(i).show())
        pList.remove(i);
    }
  }
  public void addP(int x, int y, int num, String name, int duration) {//add a particle with a duration
    pList.add(new particle(x, y, num, name, duration));
  }
  public void addP(int x, int y, int num, String name) {//add a particle with default duration
    pList.add(new particle(x, y, num, name));
  }
}