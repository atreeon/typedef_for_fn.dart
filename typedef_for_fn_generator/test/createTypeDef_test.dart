import "package:test/test.dart";
import 'package:adi_helpers/testH.dart';
import 'package:typedef_for_fn_generator/src/createTypeDef.dart';

void main() {
  final codeLines = [
    "import 'package:typedef_for_fn/typedef_for_fn.dart';",
    "@TypedefForFn() T f1<T>(int v1, T v2) => v2;",
    "@TypedefForFn() List<int> f2(int v1, List<int> v2, int v3) => List();",
    "@TypedefForFn() void f3(int input) {}",
    "@TypedefForFn() int f4(String input) => 5;",
    "@TypedefForFn() String f5() => " "blah" ";",
    "typedef fn_a = List<int> Function(int, List<int>, int)",
    "@TypedefForFn() List<int> f6(fn_a fn, int a) => fn(5, [1, 2], a);",
    "@TypedefForFn() List<int> f8(fn_a fn, int a) {fn(5, [1, 2], a);}"
  ];

  final fullFn1 = r"@TypedefForFn() T f1<T>(int v1, T v2) => v2;";
  final fullFn2 =
      r"@TypedefForFn() List<int> f2(int v1, List<int> v2, int v3) => List()";
  final fullFn3 =
      "@TypedefForFn() List<int> f8(fn_a fn, int a) {fn(5, [1, 2], a);}";

  final fnDef1 = r"T f1<T>(int v1, T v2)";
  final fnDef2 = r"List<int> f2(int v1, List<int> v2, int v3)";
  final fnDef3 = r"List<int> f8(fn_a fn, int a)";

  group("createTypeDef", () {
    void exp_createTypeDef(String fnName, String expected) {
      var result = createTypeDef(fnName, codeLines);
      expect(result, expected);
    }

    test(
        "1",
        () => exp_createTypeDef(
            "f1", "typedef fn_f1 = T Function<T>(int v1, T v2);"));
    test(
        "2",
        () => exp_createTypeDef("f2",
            "typedef fn_f2 = List<int> Function(int v1, List<int> v2, int v3);"));
    test(
        "3",
        () => exp_createTypeDef(
            "f3", "typedef fn_f3 = void Function(int input);"));
    test(
        "4",
        () => exp_createTypeDef(
            "f4", "typedef fn_f4 = int Function(String input);"));
    test("5",
        () => exp_createTypeDef("f5", "typedef fn_f5 = String Function();"));
    test(
        "6",
        () => exp_createTypeDef(
            "f6", "typedef fn_f6 = List<int> Function(fn_a fn, int a);"));
    test(
        "8",
        () => exp_createTypeDef(
            "f8", "typedef fn_f8 = List<int> Function(fn_a fn, int a);"));
  });

  group("getFnDef", () {
    void exp_getFnDef(String fullFn, String expected) =>
        expectGen(getFnDef, fullFn, expected);

    test("1", () => exp_getFnDef(fullFn1, fnDef1));
    test("2", () => exp_getFnDef(fullFn2, fnDef2));
    test("3", () => exp_getFnDef(fullFn3, fnDef3));
  });
}

//Obsolete, old code

// group("annotExists", () {
//   void exp_annotExists(String fnDef, bool expected) =>
//       expectGen(annotExists, fnDef, expected);

//   test("1", () => exp_annotExists("part 'testFunction.g.dart'", false));
//   test(
//       "2",
//       () => exp_annotExists(
//           "@TypedefForFn() T f1<T>(int v1, T v2) => v2;", true));
// });

// group("functionName", () {
//   void exp_functionName(String fnDef, String expected) =>
//       expectGen(functionName, fnDef, expected);

//   test("1", () => exp_functionName(fnDef1, "f1"));
//   test("2", () => exp_functionName(fnDef2, "f2"));
// });

// group("typedefMetaExists", () {
//   void exp_typedefMetaExists(String fnDef, bool expected) =>
//       expectGen(typedefMetaExists, fnDef, expected);

//   test("typedefMetaExists1",
//       () => exp_typedefMetaExists("part 'testFunction.g.dart'", false));
// });
