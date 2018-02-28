class word{
 String word;
  public word(String word)
 {
   this.word = word;
 }
  
  public boolean tryLetter(char letter, int index)
  {
   return (word.charAt(index) == letter);
  }
  
  String toString()
  {
   return word; 
  }
}