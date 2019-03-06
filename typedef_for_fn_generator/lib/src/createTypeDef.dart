import 'package:adi_helpers/mapH.dart';
import 'package:adi_helpers/stringH.dart';
import 'package:dartz/dartz.dart';

///To be executed in generator.
///Produces a list of function defintions where
/// an annotation exists.
String createTypeDef(
  String fnName,
  String codeLines,
  String comment, {
  String pre,
  List<String> exNames,
}) {
  if (pre == null) pre = "fn_";
  if (exNames == null) exNames = List<String>();

  var x3 = getFunctionSignature(codeLines, fnName);
  var x4 = x3.replaceFirst(fnName, "Function");

  var y1 = rmParamsFromFnSignature(x4, exNames);
  var y2 = addCommaToEndOfParameters(y1);

  var comment2 = comment == null ? "" : comment + "\n";
  var x5 = "${comment2}typedef $pre$fnName = $y2;";

  return x5;
}

///Receives all the code lines, finds the function
/// by the function name passed in 
/// then returns the found function signature
String getFunctionSignature(String codeLines, String fnName) {
  var x1 = codeLines.split("@TypedefForFn");
  var x2 = x1.skip(1);
  var x3 = x2.map((x) => x.replaceAll("(\n", "("));
  var x4 = x3.map((x) => x.replaceAll("\n", " "));
  var x5 = x4
      .map((x) => x.replaceAll("  ", " "))
      .map((x) => x.replaceAll("  ", " "))
      .map((x) => x.replaceAll("  ", " "));
  var x6 = x5.map(getFnSignatureFromCodeLine);
  var r = x6.firstWhere((x) => x.indexOf(fnName) >= 0,
      orElse: () => throw FunctionDefinitionNotFoundException());

  return r;
}

///Returns a new function signature with any parameters
/// specified in the exNames attribute removed
String rmParamsFromFnSignature(String fn, List<String> exNames) {
  if (exNames.length == 0) return fn;

  //get parameters
  var params = getParameters(fn);

  //remove any that need removing
  params.removeWhere((x, _) => exNames.contains(x));

  var x1 = getInBracketsRight(fn).getOrElse(() {});
  var y1 = fn.replaceFirst(x1, "¬`");
  var x2 = map(params, (k, v) => "$v $k").join(", ");
  var r = y1.replaceFirst("¬`", "($x2)");

  return r;
}

///Gets a list of parameters from a function signature
///inp: int Function(int a, String b)
///out: {"a": "int", "b": "String"}
Map<String, String> getParameters(String fn) {
  //take everything inside the parenthesis
  var x1 = getInBracketsRight(fn).getOrElse(() {});
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

///Takes a function signature and adds a comma to the last
/// parameter in the list of parameters
String addCommaToEndOfParameters(String fn) {
  if (fn.substring(fn.length - 2) != "()" &&
      fn.substring(fn.length - 2) != "})" &&
      fn.substring(fn.length - 2) != ",)" &&
      fn.substring(fn.length - 3) != ", )") {
    return fn.substring(0, fn.length - 1) + ",)";
  }
  return fn;
}

///Takes a codeLine and gets just the function signature
String getFnSignatureFromCodeLine(String line) {
  var isLamdaResult =
      isLambda(line).getOrElse(() => throw NoLamdaOrBracketFoundException());

  var bracketPositionOfAnnotation =
      bracketPositionLeft(line, BracketType.parenthesis).getOrElse(() {});

  if (isLamdaResult)
    return line
        .substring(bracketPositionOfAnnotation.end + 1, line.indexOf("=>"))
        .trim();

  return line
      .substring(bracketPositionOfAnnotation.end + 1, line.indexOf("{"))
      .trim();
}

///Takes a codeline and determines whether it is a lambda function
/// or a curly bracket function
Option<bool> isLambda(String codeLine) {
  var bracketPosition =
      findOutsideOfBrackets(BracketType.parenthesis, codeLine, "{");
  var firstLambda =
      findOutsideOfBrackets(BracketType.parenthesis, codeLine, "=>");

  if (bracketPosition.length == 0 && firstLambda.length == 0) return none();

  if (bracketPosition.length == 0) return some(true);
  if (firstLambda.length == 0) return some(false);

  return some(bracketPosition[0] > firstLambda[0]);
}

class FunctionDefinitionNotFoundException implements Exception {
  final String message;
  const FunctionDefinitionNotFoundException([this.message = ""]);
  String toString() => "FunctionDefinitionNotFoundException: $message";
}

class NoLamdaOrBracketFoundException implements Exception {
  final String message;
  const NoLamdaOrBracketFoundException([this.message = ""]);
  String toString() => "NoLamdaOrBracketFoundException: $message";
}

// Obsolete, old code
// String rmAnnotations(String fullFn) {
//   var level = 0;
//   var x1 = StringBuffer();
//   fullFn.runes.forEach((x) {
//     var char = String.fromCharCode(x);
//     if (char == "@") {
//       level++;
//     } else if (char == ")" && level > 0) {
//       level--;
//     } else {
//       if (level <= 0) x1.write(char);
//     }
//   });

//   var x2 = x1.toString();
//   var r = (x2[0] == ")" ? x2.substring(1) : x2).trim();
//   return r;
// }

// String rmBody(String fnNoAnnotations) {
//   var openingBracketReached = false;
//   var closingBracketReached = false;
//   var x1 = StringBuffer();

//   fnNoAnnotations.runes.forEach((x) {
//     var char = String.fromCharCode(x);
//     if (char == "(") openingBracketReached = true;
//     if (char == ")") closingBracketReached = true;
//     if (!(openingBracketReached && closingBracketReached)) x1.write(char);
//   });
//   return x1.toString() + ")";
// }

// String getFnDef(String fullFn) {
//   var x1 = rmAnnotations(fullFn);
//   var x2 = rmBody(x1);
//   return x2;
// }

// int getStartPositionOfFunctionBody(String input) {
//   var positionOfBracket = input.indexOf("{");
//   var positionOfLambda = input.indexOf("=>");
//   if (positionOfBracket < positionOfLambda) return positionOfBracket;

//   return positionOfLambda;
// }

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
