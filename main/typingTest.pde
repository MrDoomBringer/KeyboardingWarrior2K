////////////////////////////////////////////////////////////////////////////////////MADE BY ME////////////////////////////////////////////////////////////////////////////

public static final int NOEFFECT = 0;
public static final int CORRECT = 1;
public static final int INCORRECT = -1;
public static final int NEXTPHRASE = 2;

class typingTest extends minigame {
  String[] words;//list of words in the phrase
  String currentWord;//word that the user is typing
  int index;
  int[] correctList;//list of integers that corresponds to the word list. lets program know if word is correct or not.
  int start = 0;//where to start displaying the word array, useful for scrolling
  public typingTest(int x, int y, int fontSize) {
    super(x, y, fontSize);
    initPhrases();//create lists of words based on strings
    index = 0;
    currentWord = "";
    correctList = new int[words.length];//corresponds to words[]
  }

  public int tryType(char letter, int code, car playerCar) {
    if (code == SHIFT) return NOEFFECT;//if key is shift, do nothing
    else if (code == BACKSPACE) {//if backspace, reduce the current word by one character
      if (currentWord.length() > 0)
        currentWord = currentWord.substring(0, currentWord.length()-1);  
      return NOEFFECT;
    } else if (letter == ' ' || letter == ';') {
      int status = currentWord.equals(words[index])||letter==';' ? CORRECT : INCORRECT;//useful trick we found to shorten an if statement. makes status = correct if the word in the array equals the typed word (or if semicolon is pressed for debug purposes)
      correctList[index] = status;//-1 for incorrect, 0 for no effect, and 1 for correct. defined at top of file
      currentWord = "";
      index ++;
      next = !(index < words.length);//used to let the game know that the current sentence is exhausted, and we need a new one (bottom of main class handles this)
      return  status;
    }
    currentWord += Character.toString(letter);
    return NOEFFECT;
  }

  public void outputText(car playerCar) {
    x = playerCar.x+50;//x and y based on playerCars position
    y = playerCar.y;
    int downShift = 0;//downshift and horizontal shift variables
    int shift = 0;
    for (int i = start; i < words.length; i++) {//loop through the worrds[] array
      downShift += (i % 5==0 ? fontSize : 0);//useful trick we found to shorten 
                                             //if statements. For every 5 words,
                                             //increase downShfit by the fontSize, otherwise increase by zero
                                             
      if (i % 5 == 0) shift = 0;//every 5 words, reset horizontal shift to zero (corresponds to new lines)
      if (correctList[i] == CORRECT) fill(0, 255, 0);//fill the text color based on if the word was correct, 
                                                     //incorrect, or neither (as defined in correctList)
      else if (correctList[i] == INCORRECT) fill(255, 0, 0);
      else fill(255);
      text(words[i], x+shift, y+downShift);//display text one word at a time
      shift += (textWidth(words[i]+" "));//increase horizontal shift by the width of the word plus a space at the end
    }
    text(currentWord, x, y-fontSize/2);//display the currently typed word slightly above the rest of the text
    if ((index / 5.0 ) % 1 == 0 && index > 5)//if the index is greater than five, 
      start = index - 5;//then shift the start of the array (used in the above for-loop) to 5 words back.
  }

  public void initPhrases() {
    String[] temp = {
      "The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly but gets faster each minute after you hear this signal. beep A single lap should be completed each time you hear this sound. ding Remember to run in a straight line and run as long as possible. The second time you fail to complete a lap before the sound your test is over. The test will begin on the word start. On your mark get ready start.", 
      "A bird in the hand is worth 2 in the bush but a bush in the hand is worth 2 on the bird", 
      "People dont think it be how it is but it do", 
      "Oh hi mark", 
      "The mitochondria is the powerhouse of the cell", 
      "Get thee to a nunnery", 
      "When life gives you lemons", 
      "Yuo see ivan if amerecan is not no of phrase will fail test", 
      "Snap into a slim jim", 
      "Its nerf or nuthin", 
      "Omae wa mou shindeiru", 
      "December 1st 1941 a day that will live in infamy", 
      "Four score and seven years ago our fathers brought upon this land", 
      "If fighting is sure to result in victory then you must fight", 
       "Game over man game over!", 
      "Ms kolly is the greatest", 
    };
    words = temp[rand.nextInt(temp.length)].split(" ");//gets a random phrase and split it into an array based on " " characters
  }
}