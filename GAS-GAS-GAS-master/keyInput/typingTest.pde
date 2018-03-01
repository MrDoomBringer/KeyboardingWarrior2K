import java.util.Random;
class typingTest extends minigame{
  
  ArrayList<word> currentPhrase;
  int currentWord;
  int currentIndex;
  int shift;
  int counter;
  String[] phrases = 
{
"the quick brown fox", 
"test dd ddd ddddd ",
"asdf dsfdsaf ",
"buenos asdf ",
"dias mandy"
};

//list of all possible phrases
  public typingTest(int x, int y, int fontSize){
    super(x,y,fontSize);
    currentPhrase = new wordGroup(phrases[rand.nextInt(phrases.length)]).getWordGroup();
    currentIndex = 0;
    currentWord = 0;
  }
  
  public boolean tryType(char letter){
    if(currentPhrase.get(currentWord).tryType(letter,currentIndex))
    {
      currentIndex++;
      if (currentIndex >= currentPhrase.get(currentWord).length())
      {
        currentWord++;
        currentIndex = 0;
      }
      
    }
    return true;
  }
  
  public void outputText()
  {
    shift = 0;
    counter = 0;
  for (int i = 0; i < currentPhrase.size(); i++){
    for (int j = 0; j < currentPhrase.get(i).getLetters().size(); j++){
      if (counter < currentIndex)
        fill(255,0,0);
      else
        fill(255);
      text(currentPhrase.get(i).charAt(j),shift,50);
      shift += fontSize/2;
      counter ++;
    }
    shift += fontSize/2;
  }
  }
  
  
}