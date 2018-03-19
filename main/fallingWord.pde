class fallingWord extends movable {
  String word;
  boolean special;
  public fallingWord(int x, int y, String word, boolean special) {
    super(x, y);
    this.word = word;
    this.special = special;
  }
  public boolean check(String word) {
    return this.word.equals(word);
  }
  public void output(int fontSize) {
    if (special) {
      fill(255, 255, 0);
      textSize(fontSize*2);
      text(word, x, y);
      fill(255);
      textSize(fontSize);
    } else
      text(word, x, y);
  }
}