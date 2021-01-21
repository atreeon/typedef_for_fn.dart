import 'package:quiver/core.dart';
import 'package:dartz/dartz.dart';
import 'package:typedef_for_fn_generator/src/helpers/regexH.dart';

///Creates a string of the determined number of spaces
///inp: 5
///out: "     "
String createSpaces(int number) {
  var str = "";
  for (var i = 0; i < number; i++) {
    str = str + " ";
  }
  return str;
}

///Finds the brackets furthest to the right '(L) (R)'
///inp: bl(blim) (plumpy(stumpy))
///out: (plumpy(stumpy))
Option<String> getInBracketsRight(String input, BracketType bracketType) {
  return bracketPositionRight(input, bracketType)
      .bind((x) => some(input.substring(x.start - 1, x.end + 1)));
}

///Gets the first full word from the beginning of the text
///delimited by a space
///inp: blah<blim> fn
///out: blah<blim>
String firstWord(String source) {
  return regEx1(r"([^\s]+)", source);
}

///Finds the brackets furthest to the right '(L) (R)'
///Returns a start and end position
///inp: bl(blim) (plumpy(stumpy))
///out: 10, 24;
Option<StrPos> bracketPositionRight(String source, BracketType bracketType) {
  var bracket = getBracket(bracketType);

  //TODO: need to find and remove all strings and brackets & remove the brackets from there (or not count them)

  //remove bracket and space to the right
  var startIndex = source.lastIndexOf(bracket.end) - 1; //

  //per char check for closing bracket
  var bracketCount = -1;
  for (var i = startIndex; i >= 0; i--) {
    if (source[i] == bracket.start) bracketCount++;
    if (source[i] == bracket.end) bracketCount--;

    if (bracketCount == 0) return some(StrPos(i + 1, startIndex + 1));
  }

  return none();
}

///Finds the brackets furthest to the left '(L) (R)'
///Returns a start and end position
///inp: bl(blim) (plumpy(stumpy))
///out: 2, 7
Option<StrPos> bracketPositionLeft(String source, BracketType bracketType) {
  var bracket = getBracket(bracketType);

  //remove bracket and space to the right
  var startIndex = source.indexOf(bracket.start) + 1; //

  //per char check for closing bracket
  var bracketCount = 1;
  for (var i = startIndex; i < source.length; i++) {
    if (source[i] == bracket.start) bracketCount++;
    if (source[i] == bracket.end) bracketCount--;

    if (bracketCount == 0) return some(StrPos(startIndex, i));
  }

  return none();
}

///Gets the starting positions of the pattern inside brackets
///inp: aaa,aaaa<aa,a,>aa,a |
///out: [3,17]
List<int> findOutsideOfBrackets(
    BracketType bracketType, String source, String pattern) {
  var bracket = getBracket(bracketType);

  var level = 0;
  var x1 = StringBuffer();
  source.runes.forEach((x) {
    var char = String.fromCharCode(x);
    if (char == bracket.start) level++;
    if (char == bracket.end) level--;
    x1.write(level == 0 ? char : "¬");
  });
  var x2 = x1.toString();

  var rgx = RegExp(pattern);
  var r = rgx.allMatches(x2).map((x) => x.start).toList();
  return r;
}

enum BracketType { angled, curly, square, parenthesis }

///A container to record the starting and ending bracket characters
class Bracket {
  final BracketType bracketType;
  final String start;
  final String end;

  Bracket(this.bracketType, this.start, this.end);
}

///The data for Bracket
final bracketData = [
  Bracket(BracketType.angled, "<", ">"),
  Bracket(BracketType.curly, "{", "}"),
  Bracket(BracketType.square, "[", "]"),
  Bracket(BracketType.parenthesis, "(", ")"),
];

///Gets the related bracket data line for the bracket type
Bracket getBracket(BracketType bracketType) =>
    bracketData.firstWhere((x) => x.bracketType == bracketType);

///Splits a string at the indices passed in
List<String> splitByIndices(String source, List<int> positions) {
  if (positions.length == 0) return [source];

  if (positions[0] != 0) positions.insert(0, 0);
  if (positions[positions.length - 1] != source.length)
    positions.insert(positions.length, source.length);

  var x1 = List<String>();
  for (var i = 0; i < positions.length - 1; i++) {
    x1.add(source.substring(positions[i], positions[i + 1]));
  }

  return x1;
}

///Splits a string into two where it finds the pattern
/// closest to the right of the string
///inp: "this is a test", " "
///out: ["this is a", "test"]
List<String> splitByLastOf(String source, String pattern) {
  var i = source.lastIndexOf(pattern);
  var r = [source.substring(0, i), source.substring(i + 1)];
  return r;
}

///Object to record the start and end positions in a string
class StrPos {
  final int start;
  final int end;
  StrPos(this.start, this.end);

  toString() => "$start,$end";

  bool operator ==(o) => o is StrPos && start == o.start && end == o.end;
  int get hashCode => hash2(start.hashCode, end.hashCode);
}

///Replace all punctuation with a space
///replace any spaces with just one char
///Trim any spaces from end and beginning of word
///[,.;@#?!&$]
String removePunctuation(String input) {
  var removedChars = input.replaceAll( RegExp(r"[,.;@#?!&$'-/()]"), ' ');
//  var removedChars = input.replaceAll(r'h+', "XXX");
//  var removedDoubleSpaces = removedChars.replaceAll(RegExp(r"  +"), "z");
  var removedDoubleSpaces = removedChars.replaceAll("  ", " ");
  var removedDoubleSpaces2 = removedDoubleSpaces.replaceAll("  ", " ");

  return removedDoubleSpaces2.trim();
}