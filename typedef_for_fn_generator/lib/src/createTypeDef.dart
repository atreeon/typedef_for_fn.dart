import 'package:adi_helpers/mapH.dart';
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

  var y1 = formatFn(x4, exNames);
  var x5 = "typedef $pre$fnName = $y1;";

  return x5;
}

String formatFn(String fn, List<String> exNames) {
  if (exNames.length == 0) return fn;

  //get parameters
  var params = getParameters(fn);

  //remove any that need removing
  params.removeWhere((x, _) => exNames.contains(x));

  var x1 = getInBracketsRight(fn);
  var y1 = fn.replaceFirst(x1, "¬`");
  var x2 = map(params, (k, v) => "$v $k").join(", ");
  var r = y1.replaceFirst("¬`", "($x2)");

  return r;
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

String rmAnnotations(String fullFn) {
  var level = 0;
  var x1 = StringBuffer();
  fullFn.runes.forEach((x) {
    var char = String.fromCharCode(x);
    if (char == "@") {
      level++;
    } else if (char == ")" && level > 0) {
      level--;
    } else {
      if (level <= 0) x1.write(char);
    }
  });

  var x2 = x1.toString();
  var r = (x2[0] == ")" ? x2.substring(1) : x2).trim();
  return r;
}

String rmBody(String fnNoAnnotations) {
  var openingBracketReached = false;
  var closingBracketReached = false;
  var x1 = StringBuffer();

  fnNoAnnotations.runes.forEach((x) {
    var char = String.fromCharCode(x);
    if (char == "(") openingBracketReached = true;
    if (char == ")") closingBracketReached = true;
    if (!(openingBracketReached && closingBracketReached)) x1.write(char);
  });
  return x1.toString() + ")";
}

String getFnDef(String fullFn) {
  var x1 = rmAnnotations(fullFn);
  var x2 = rmBody(x1);
  return x2;
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
