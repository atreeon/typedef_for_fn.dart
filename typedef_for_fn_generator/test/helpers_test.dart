import 'package:generator_common/classes.dart';
import 'package:test/test.dart';
import 'package:typedef_for_fn_generator/src/helpers.dart';

void main() {
  group("getFunction", () {
    test("1 a", () {
      var methodDetails = MethodDetails(
        "///blah",
        "methodName",
        [NameTypeWithComment("param1", "String")],
        [NameTypeWithComment("param2", "int")],
        [],
        "List<String>",
      );

      var result = getFunctionDefinition(methodDetails);

      expect(result, """
///blah
List<String> Function(
String param1,{
required int param2})""");
    });

    test("2 a With generics", () {
      var methodDetails = MethodDetails(
        "///blah",
        "methodName",
        [NameTypeWithComment("param1", "String")],
        [NameTypeWithComment("param2", "int")],
        [GenericsNameType("T", "int")],
        "T",
      );

      var result = getFunctionDefinition(methodDetails);

      expect(result, """
///blah
T Function<T extends int>(
String param1,{
required int param2})""");
    });
  });
}
