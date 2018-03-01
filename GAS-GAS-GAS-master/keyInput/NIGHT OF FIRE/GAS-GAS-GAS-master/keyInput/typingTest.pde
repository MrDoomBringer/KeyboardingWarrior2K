import java.util.Random;
class typingTest extends minigame{
  
  String currentPhrase;
  int[] correctList;
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
    currentPhrase = phrases[rand.nextInt(phrases.length)];
    correctList = new int[currentPhrase.length()];
    currentIndex = 0;
  }
  
  public boolean tryType(char letter){
    if (currentPhrase.charAt(currentIndex) == letter)
    {
    currentIndex++;
    correctList[currentIndex] = 1;
    }
    return true;
  }
  
  public void outputText()
  {
    shift = 0;
    counter = 0;
  for (int i = 0; i < currentPhrase.length(); i++){
      text(currentPhrase.charAt(i),shift,50);
      if (correctList[i] == 1)
        fill(0,255,0);
      else if (correctList[i] == 0)
        fill(255,0,0);
      else
        fill(255);
      shift += fontSize/2;
      counter ++;
    }
  }
  }
  
  