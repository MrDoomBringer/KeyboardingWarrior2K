class fallingWord extends movable {
  String word;
  public fallingWord(int x, int y, String word) {
    super(x, y);
    this.word = word;
  }

  public boolean check(String word){
    return this.word.equals(word);
  }
}