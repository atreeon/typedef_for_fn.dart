import 'package:adi_helpers/regexH.dart';
import 'package:adi_helpers/stringCurriedH.dart';
import 'package:adi_helpers/stringH.dart';

String createTypeDef(String fnName, List<String> codeLines,
    {String pre, List<String> exNames}) {
  if (pre == null) pre = "fn_";
  if (exNames == null) exNames = List<String>();

  var x1 = codeLines.where(contains("@TypedefForFn"));
  var x2 = x1.firstWhere(contains(fnName));
  var x3 = getFnDef(x2);
  var x4 = x3.replaceFirst(fnName, "Function");
  var x5 = "typedef $pre$fnName = $x4;";

  return x5;
}

String formatTypeDef(String fn, {List<String> exNames}) {
  if (exNames.length == 0) return fn;

  //get parameters
  var x1 = getParameters(fn);

  //remove any that need removing
  x1.removeWhere((x, _) => exNames.contains(x));

  var y1 = getInBracketsRight(fn);

  var z1 = fn.replaceFirst(y1, "¬`");

  

  //rightmostBrackets(x4).replace("")
  //write parameters
}

///Gets a list of parameters from a function definition
///inp: int Function(int a, String b)
///out: {"a": "int", "b": "String"}
Map<String, String> getParameters(String fn) {
  //take everything inside the parenthesis
  var x1 = getInBracketsRight(fn);
  var x2 = x1.substring(1, x1.length - 1);

  if (x2.length == 0) return {};

  //split by commas (excluding those in generic brackets)
  var y1 = findOutsideOfBrackets(BracketType.angled, x2, ",");
  var z1 = splitByIndices(x2, y1);

  //remove commas between parameters
  var z2 = z1.map((x) => x[0] != "," ? x : x.substring(1));

  //turn into a map
  var z3 = z2.map((x) => splitByLastOf(x, " ")).toList();
  var r = Map<String, String>.fromIterables(
      z3.map((x) => x[1].trim()), z3.map((x) => x[0].trim()));

  return r;
}

String getFnDef(String fullFn) {
  var z1 = fullFn.indexOf(")") + 1;
  var y1 = regExIndexOf1("=>|{", fullFn);
  var r = fullFn.substring(z1, y1).trim();
  return r;
}

// Obsolete, old code
// bool fnNameExists(String fnName, String fnDef) {
//   return fnDef.indexOf(fnName) != -1;
// }

// bool annotExists(String item) {
//   return item.indexOf("@TypedefForFn") != -1;
// }

// ///From function definition gets the function name for the type definition
// ///inp: f1<T>(int v1, T v2) → T
// ///out: fn_f1
// String functionName(String fnDef) {
//   var x1 = fnDef.split(" ")[1];
//   var y1 = regExIndexOf1("[(<]", x1);
//   var x2 = x1.substring(0, y1);
//   return x2;
// }
