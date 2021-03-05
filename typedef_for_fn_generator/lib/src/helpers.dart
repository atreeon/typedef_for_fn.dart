import 'package:generator_common/classes.dart';

String getTypeDefName({required String methodName}) => //
    "fn_${methodName}";

//final String Function(String name,) fn;
String getFunctionDefinition(
  MethodDetails methodDetails,
) {
  if (methodDetails.paramsPositional.length == 0 && methodDetails.paramsNamed.length == 0) {
    return "${methodDetails.returnType} Function()";
  }

  var strParamsPositional = methodDetails.paramsPositional.map((x) => //
      "${formattedComment(x.comment)}${x.type} ${x.name}").join(",\n");

  var strParamsNamed = methodDetails.paramsNamed
      .map((x) => //
          x.type.contains("?") //
              ? "${formattedComment(x.comment)}${x.type} ${x.name}"
              : "${formattedComment(x.comment)}required ${x.type} ${x.name}")
      .join(",\n");

  var params = [
    if (methodDetails.paramsPositional.isNotEmpty) //
      strParamsPositional,
    if (methodDetails.paramsNamed.isNotEmpty) //
      "{\n$strParamsNamed}",
  ].join(",");

  var genericList = methodDetails.generics
      .map((e) => e.type == null //
          ? e.name
          : "${e.name} extends ${e.type}")
      .join(",");

  var genericsFormatted = methodDetails.generics.length > 0 ? "<${genericList}>" : "";

  return "${methodDetails.returnType} Function${genericsFormatted}(\n$params)";
}

String formattedComment(String? comment) {
  return comment == null ? "" : comment + "\n";
}
