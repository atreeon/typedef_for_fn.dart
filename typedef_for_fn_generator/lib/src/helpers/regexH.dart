///Returns the first match
String regEx1(String pattern, String source) {
  var rgx = RegExp(pattern);
  var first = rgx.firstMatch(source);
  if (first == null) //
    return "";

  return first[0];
}

//Returns the index position of the first match
int regExIndexOf1(String pattern, String source) {
  var rgx = RegExp(pattern);
  var first = rgx.firstMatch(source);
  if (first == null) //
    return -1;

  return first.start;
}
