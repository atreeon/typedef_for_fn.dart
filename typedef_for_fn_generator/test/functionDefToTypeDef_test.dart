import "package:test/test.dart";
import 'package:typedef_for_fn_generator/src/functionDefToTypeDef.dart';

void main() {
  final fnDef1 = "f1<T>(int v1, T v2) → T";
  final fnDef2 = "f2(int v1, List<int> v2, int v3) → List<int>";
  final fnDef3 = "f3(int input) → void";
  final fnDef4 = "f4(String input) → int";
  final fnDef5 = "f5() → String";

  void expectGen(Function fnToTest, String fnDef, String expected) {
    expect(fnToTest(fnDef), expected, reason: "input:" + fnDef);
  }

  group("functionDefToTypeDef", () {
    void expect_functionDefToTypeDef(String fnDef, String expected) =>
        expectGen(functionDefToTypeDef, fnDef, expected);

    test("functionDefToTypeDef1",
        () => expect_functionDefToTypeDef(fnDef1, "typedef fn_f1 = T Function<T>(int, T);"));
    test(
        "functionDefToTypeDef2",
        () => expect_functionDefToTypeDef(
            fnDef2, "typedef fn_f2 = List<int> Function(int, List<int>, int);"));
    test("functionDefToTypeDef3",
        () => expect_functionDefToTypeDef(fnDef3, "typedef fn_f3 = void Function(int);"));
    test("functionDefToTypeDef4",
        () => expect_functionDefToTypeDef(fnDef4, "typedef fn_f4 = int Function(String);"));
    test("functionDefToTypeDef5",
        () => expect_functionDefToTypeDef(fnDef5, "typedef fn_f5 = String Function();"));
  });

  group("functionName", () {
    void expect_functionName(String fnDef, String expected) =>
        expectGen(functionName, fnDef, expected);

    test("functionName1", () => expect_functionName(fnDef1, "fn_f1"));
    test("functionName2", () => expect_functionName(fnDef2, "fn_f2"));
  });

  group("genericDef", () {
    void expect_genericDef(String fnDef, String expected) => expectGen(genericDef, fnDef, expected);

    test("genericDef1", () => expect_genericDef(fnDef1, "<T>"));
    test("genericDef2", () => expect_genericDef(fnDef2, ""));
    test("genericDef3", () => expect_genericDef(fnDef3, ""));
    test("genericDef_a", () => expect_genericDef("f1<T1,T2>(int v1, T v2) → T1", "<T1,T2>"));

  });

  group("returnType", () {
    void expect_returnType(String fnDef, String expected) => expectGen(returnType, fnDef, expected);

    test("returnType1", () => expect_returnType(fnDef1, "T"));
    test("returnType2", () => expect_returnType(fnDef2, "List<int>"));
    test("returnType3", () => expect_returnType(fnDef3, "void"));
    test("returnType4", () => expect_returnType(fnDef4, "int"));
    test("returnType5", () => expect_returnType(fnDef5, "String"));
  });

  group("parameterTypes", () {
    void expect_parameterTypes(String fnDef, String expected) =>
        expectGen((x) => parameterTypes(x).toString(), fnDef, expected);

    test("parameterTypes1", () => expect_parameterTypes(fnDef1, "(int, T)"));
    test("parameterTypes2", () => expect_parameterTypes(fnDef2, "(int, List<int>, int)"));
    test("parameterTypes3", () => expect_parameterTypes(fnDef3, "(int)"));
    test("parameterTypes4", () => expect_parameterTypes(fnDef4, "(String)"));
    test("parameterTypes5", () => expect_parameterTypes(fnDef5, "()"));
  });
}

// group("functionDefToTypeDef", () {
//   void expectFunctionDefToTypeDef(String functionDefInput, String typedefExpected) {
//     var result = functionDefToTypeDef(functionDefInput);
//     expect(typedefExpected, result);
//   }

//   test("1", () {
//     final typedefExpected = "typedef fn_f1 = T Function<T>(int, T);";
//     expectFunctionDefToTypeDef(fnDef1, typedefExpected);
//   });

//   test("2", () {
//     final typedefExpected = "typedef fn_f2 = List<int> Function(int, List<int>, int);";
//     expectFunctionDefToTypeDef(fnDef2, typedefExpected);
//   });

//   test("3", () {
//     final typedefExpected = "typedef fn_f3 = void Function(int);";
//     expectFunctionDefToTypeDef(fnDef3, typedefExpected);
//   });

//   test("4", () {
//     final typedefExpected = "typedef fn_f4 = int Function(String);";
//     expectFunctionDefToTypeDef(fnDef4, typedefExpected);
//   });

//   test("5", () {
//     final typedefExpected = "typedef fn_f5 = String Function();";
//     expectFunctionDefToTypeDef(fnDef5, typedefExpected);
//   });
// });
