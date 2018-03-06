class word{//class exists to add more functionality to words
 String word;
 ArrayList<Character> letters;
 public word(String word)
 {
   letters = new ArrayList<Character>();
   for (int i = 0; i < word.length(); i++)
     letters.add(word.charAt(i));
 }
  
  public boolean tryType(char letter, int index)
  {
     return (letters.get(index) == letter);
  }
  
  public ArrayList<Character> getLetters()
  {
   return letters; 
  }
  
  public char charAt(int index)
  {
    return letters.get(index);
  }
  
  public int length()
  {
   return letters.size(); 
  }
  String toString()
  {
   return word; 
  }
}