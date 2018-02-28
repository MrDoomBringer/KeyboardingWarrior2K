class wordGroup
{
 ArrayList<String> wordGroup;
 public wordGroup(String group)
 {
   wordGroup = new ArrayList<String>();
   while (group.length() > 1){
   wordGroup.add(group.substring(0,group.indexOf(' ')));
   group = group.substring(group.indexOf(' ')+1);  
   if (group.indexOf(' ') == -1)
   {  
     wordGroup.add(group);
     group = "";
   }
 }
 }
 
 public ArrayList<String> getWordGroup()
 {
  return wordGroup; 
 }
  
  
}