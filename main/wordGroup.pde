class wordGroup
{
  ArrayList<word> wordGroup;
  public wordGroup(String group)
  {
    wordGroup = new ArrayList<word>();
    while (group.length() > 1) {
      wordGroup.add(new word(group.substring(0, group.indexOf(' '))));
      group = group.substring(group.indexOf(' ')+1);  
      if (group.indexOf(' ') == -1)
      {  
        wordGroup.add(new word(group));
        group = "";
      }
    }
  }

  public ArrayList<word> getWordGroup()
  {
    return wordGroup;
  }
}