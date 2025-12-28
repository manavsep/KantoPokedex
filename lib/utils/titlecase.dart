class Titlecase {

  static String titleCase(String text){
    String newText = text[0].toUpperCase()+text.substring(1);
    return newText;
  }
}