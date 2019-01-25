// String functionDefToTypeDef(String functionDef){
//   //extract function name
//   //extract parameters
//   //extract return type
// }

String functionName(String functionDef) {
  var rx = RegExp(r"^([a-zA-Z0-9_$]*)");
  var first = rx.firstMatch(functionDef);
  return "fn_" + first[0];
}

String genericDef(String functionDef) {
  var rx = RegExp(r"(<[a-zA-Z0-9_$, ]*>)");
  var first = rx.firstMatch(functionDef);
  return first == null ? "" : first[0];
}

// List<String> parameterTypes(String functionDef){
//   //everything inside brackets
//   //split by comma
// }

// String returnType(String functionDef){
//   //everything after → symbol
// }
