import "package:test/test.dart";
import 'package:typedef_for_fn_generator/src/functionDefToTypeDef.dart';

void main() {
  final fnDef1 = "f1<T>(int v1, T v2) → T";
  final fnDef2 = "f2(int v1, List<int> v2, int v3) → List<int>";
  final fnDef3 = "f3(int input) → void";
  final fnDef4 = "f4(String input) → int";
  final fnDef5 = "f5() → String";

  //this could be removed
  void expectGen(Function fnToTest, String fnDef, String expected) {
    expect(fnToTest(fnDef), expected, reason: "input:" + fnDef);
  }

  void expect_functionName(String fnDef, String expected) =>
      expectGen(functionName, fnDef, expected);

  test("functionName", () {
    expect_functionName(fnDef1, "fn_f1");
    expect_functionName(fnDef2, "fn_f2");
    expect_functionName(fnDef3, "fn_f3");
    expect_functionName(fnDef4, "fn_f4");
    expect_functionName(fnDef5, "fn_f5");
  });

  void expect_genericDef(String fnDef, String expected) => expectGen(genericDef, fnDef, expected);

  test("genericDef", () {
    expect_genericDef(fnDef1, "<T>");
    expect_genericDef("f1<T1,T2>(int v1, T v2) → T1", "<T1,T2>");
    expect_genericDef(fnDef3, "");
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
