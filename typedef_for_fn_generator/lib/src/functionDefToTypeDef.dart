String functionDefToTypeDef(String functionDef) {
  return "typedef " + //
      functionName(functionDef) +
      " = " +
      returnType(functionDef) +
      " Function" +
      genericDef(functionDef) +
      parameterTypes(functionDef) +
      ";";
}

String functionName(String functionDef) {
  var rx = RegExp(r"^([a-zA-Z0-9_$]*)");
  var first = rx.firstMatch(functionDef);
  return "fn_" + first[0];
}

String genericDef(String functionDef) {
  var rx1 = RegExp(r".+?(?=\()");
  var first1 = rx1.firstMatch(functionDef);

  var rx2 = RegExp(r"(<[a-zA-Z0-9_$, ]*>)");
  var first = rx2.firstMatch(first1[0]);
  return first == null ? "" : first[0];
}

String parameterTypes(String functionDef) {
  //f1<T>(int v1, T v2) → T || (int v1, T v2)
  var rx = RegExp(r"\((.*?)\)");
  var first = rx.firstMatch(functionDef);
  if (first == null) return "()";

  //remove brackets || int v1, T v2
  var stuff = first[0].replaceAll("(", "");
  var stuff2 = stuff.replaceAll(")", "");

  //split by comma || ["int v1", "T v2"]
  var result = stuff2.split(", ");
  if (result.length == 0 || result[0].length == 0) return "()";

  //map take first word || ["int", "T"]
  var result2 = result.map((x) => x.substring(0, x.indexOf(" "))).toList();

  return result2.toString().replaceAll("[", "(").replaceAll("]", ")");
}

String returnType(String functionDef) {
  var location = functionDef.indexOf(" → ");
  return functionDef.substring(location + 3);
}
