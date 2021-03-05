import 'package:generator_common/classes.dart';

import 'helpers.dart';

///output:
///typedef fn_triggerTextVMFromState = TriggerTextVM Function(
///    Translation translation,
///    Lecture lecture,
///    );
String createTypedefForFn({
  required MethodDetails methodDetails,
}) {
  var sb = StringBuffer();

  sb.writeln("${formattedComment(methodDetails.methodComment)}");
  sb.writeln("typedef ");
  sb.writeln(getTypeDefName(methodName: methodDetails.methodName));
  sb.writeln(" = ");
  sb.writeln(getFunctionDefinition(methodDetails));
  sb.writeln(";");

  return sb.toString();
}
