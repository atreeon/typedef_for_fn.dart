import 'package:adi_helpers/regexH.dart';
import 'package:adi_helpers/stringCurriedH.dart';

//name and level too
String createTypeDef(String fnName, List<String> codeLines,
    {String pre = "fn_"}) {
  var x1 = codeLines.where(contains("@TypedefForFn"));
  var x2 = x1.map(getFnDef);
  var x3 = x2.firstWhere(contains(fnName));
  var x4 = x3.replaceFirst(fnName, "Function");
  var x5 = "typedef $pre$fnName = $x4;";
  return x5;
}

String getFnDef(String fullFn) {
  var y1 = regExIndexOf1("=>|{", fullFn);
  var z1 = fullFn.indexOf(")") + 1;
  var x1 = fullFn.substring(z1, y1).trim();
  return x1;
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
