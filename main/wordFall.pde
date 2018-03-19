////////////////////////////////////////////////////////////////////////////////////MADE BY ////////////////////////////////////////////////////////////////////////////

public static final int POWERUP = 3;//used to tell when the user is "powered up"

class wordFall extends minigame
{
  PFont font;
  int fontSize;
  int oldTime;
  ArrayList<fallingWord> words;
  String currentWord;
  String[] wordChoices;
  int index;//used to go down the possible list of words and print them out
  int counter;//used to, every 16 calls of outputText, create a new word to type
  int status;//if the word was typed successfully
  int powerUpTimer;//allows powerups to last for a certain amount of time
  public wordFall(int x, int y, int fontSize)
  {
    super(x, y, fontSize);
    this.fontSize = fontSize;//we use this.fontSize to differentiate from the constructers variable and the classes variable
    font = createFont("Consolas", fontSize);
    textFont(font);
    words = new ArrayList<fallingWord>();//create an arrayList of falling words
    currentWord = "";//current typed word
    words.add(new fallingWord(rand.nextInt(width-20)+20, 0, "dab", false));
    oldTime = 0;
    wordChoices = loadStrings("1000.txt");//there are 1000 word choices in an array read line by line from a text file
    index = 0;
    counter = 0;
    powerUpTimer = 0;
  }
  public void outputText(car playerCar) {
    if (counter%16==0) {//create a new random word every 16 times this function is called
      boolean special = rand.nextInt(60)<playerCar.streak;//higher chance to create a special word (gives powerups) if the player's streak (correct words in a row) is higher
      words.add(new fallingWord(rand.nextInt(width-80), 0, wordChoices[index], special));
      index++;
      if (index == 1000)
        index = 0;
    }
    counter++;

    text(currentWord, playerCar.x, playerCar.y);//output typed word above car
    for (int i = words.size()-1; i >= 0; i--) {
      words.get(i).output(fontSize);//if word special, show as twice as big
      words.get(i).y+=4;//words move down
      if (words.get(i).y > height-fontSize) {
        imgHandler.pm.addP(words.get(i).x, words.get(i).y, music.position(), "boom 2");//create an explosion and damage user if they reach bottom of screen
        playerCar.damage(1);
        words.remove(words.get(i));
      }
    }
    if (status == POWERUP) {//create a blue bar on top right that shows how much time is left in the pwoer up
      powerUpTimer++;
      fill(0, 255, 255);
      rect(width-50, 50, 45, 100);
      fill(0, 128, 128);
      rect(width-50, 50, 45, powerUpTimer);
      fill(255);
    }
    if (status == POWERUP && powerUpTimer >=100) {//once the powerup timer runs out, set the status off of POWERUP and use up the palyers streak
      status = NOEFFECT;
      currentWord = "";
      playerCar.streak = 0;
    }
  }

  public int tryType(char letter, int code, car playerCar) {
    if (status == POWERUP && words.size() > 1) {  //if the user is powered up, no matter what you type, you instantly get the word correct
      fallingWord w = words.get(words.size()-1);
      imgHandler.pm.addP(w.x, w.y, music.position(), "boom");
      playerCar.word = w;//useful for letting the car know where to go after getting the word correct
      words.remove(w);
      currentWord = "";
      return CORRECT;
    }
    if (code == SHIFT) return NOEFFECT;//if shift key, do nothing
    else if (code == BACKSPACE) {
      if (currentWord.length() > 0)//make the currently typed word one character shorter
        currentWord = currentWord.substring(0, currentWord.length()-1);  
      return NOEFFECT;
    } else if (letter == ' ' || letter == ';') {//consider a word to be finished once the space key is pressed (semicolon for debug)
      for (fallingWord w : words)
        if (w.word.equals(currentWord) || letter == ';') { //go through each word and check if it equals the typed word
          imgHandler.pm.addP(w.x, w.y, music.position(), "nice");//create a "nice" image on the right word after you type it
          playerCar.x = w.x;//move the car underneath the word
          playerCar.word = w;//useful for letting the car know where to go after getting the word correct
          if (w.special) {
            status = POWERUP;
            imgHandler.pm.addP(w.x, w.y, music.position(), "instantType", 2);//big, slow moving particle if you get a special word
            powerUpTimer = 0;
          } else status = CORRECT;
          words.remove(w);
          currentWord = "";
          return status;
        }
      imgHandler.pm.addP(blueCar.x, blueCar.y, music.position(), "wrong");//if the user hits "space" but the typed word doesnt equal any word displayed, then they are incorrect
      currentWord = "";
      return INCORRECT;
    }
    currentWord += Character.toString(letter);//add whatever is typed to the currentWord
    return NOEFFECT;
  }
}