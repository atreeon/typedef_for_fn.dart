import 'package:adi_helpers/regexH.dart';
import 'package:adi_helpers/stringH.dart';

//try it
//work out what to do for dynamic problem (because code not generated fn = dynamic!), manual copy probably

///Takes a function definition and converts it to a function type
///inp: <T>(T, List<int>, int) → int fn
///out: int Function<T>(T, List<int>, int)
String fnDefToFnType(String fnDef) {
  return returnType(fnDef) + //
      " Function" +
      genericDef(fnDef) +
      "(" +
      splitParameters(fnDef) +
      ")";
}

///Creates a typedef from a function definition, this
///WARNING: Does not handle generic functions as a function definition parameter
///inp: f1<T>(int v1, T v2) → T
///out: typedef fn_f1 = T Function<T>(int, T);
String functionDefToTypeDef(String functionDef) {
  return "typedef " + //
      functionName(functionDef) +
      " = " +
      returnType(functionDef) +
      " Function" +
      genericDef(functionDef) +
      "(" +
      splitParameters(functionDef) +
      ");";
}

///From function definition gets the function name for the type definition
///inp: f1<T>(int v1, T v2) → T
///out: fn_f1
String functionName(String functionDef) {
  var rx = RegExp(r"^([a-zA-Z0-9_$]*)");
  var first = rx.firstMatch(functionDef);
  return "fn_" + first[0];
}

///gets the generic part of a function definition
///inp: f1<T>(int v1, T v2) → T
///out: <T>
String genericDef(String functionDef) {
  var rx1 = RegExp(r".+?(?=\()");
  var first1 = rx1.firstMatch(functionDef);
  if (first1 == null) return "";

  var rx2 = RegExp(r"(<[a-zA-Z0-9_$, ]*>)");
  var first = rx2.firstMatch(first1[0]);
  return first == null ? "" : first[0];
}

///From a function definition we extract and format the parameters
/// including the typed functions
///WARNING: Does not handle generic functions as a function definition parameter
///inp: f1<T>(int v1, T v2) → T
///out: int, T
String splitParameters(String functionDef) {
  var parameters = getInBracketsRight(functionDef);
  parameters = parameters.substring(1, parameters.length - 1);
  if (parameters == "()") return "";

  var paramsMinusFunctions = parameters;
  var fnParams = List<String>();

  while (paramsMinusFunctions.indexOf("→") > 0) {
    var arrowIndex = paramsMinusFunctions.indexOf("→");
    var fnStartPos = bracketPositionRight(parameters.substring(0, arrowIndex)).value.start;
    var fnReturnTypePosition =
        arrowIndex + 2 + regExIndexOf1(r"[\s,(]", parameters.substring(arrowIndex + 2));
    var fnDef = parameters.substring(fnStartPos - 1, fnReturnTypePosition);
    var fnType = fnDefToFnType(fnDef);
    fnParams.add(fnType);
    paramsMinusFunctions = // _x_ placeholder to preserver order, not so clean!
        paramsMinusFunctions.replaceRange(fnStartPos - 1, fnReturnTypePosition, "_x_");
  }

  var normalParams = paramsMinusFunctions.split(",");
  normalParams = normalParams.map((x) => firstWord(x)).toList();

  for (var i = 0; i < normalParams.length; i++) {
    if (normalParams[i] == "_x_") normalParams[i] = fnParams.removeAt(0);
  }

  return normalParams.toString().replaceAll("[", "").replaceAll("]", "");
}

///From a function defnition we extract the return type
///inp: f1<T>(int v1, T v2) → T
///out: List<int>
String returnType(String functionDef) {
  var location = functionDef.lastIndexOf(" → ");
  var afterArrow = functionDef.substring(location);
  var secondWord = afterArrow.split(" ")[2];
  return secondWord;
}

