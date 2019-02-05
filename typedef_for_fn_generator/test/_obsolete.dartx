import "package:test/test.dart";
import 'package:typedef_for_fn_generator/src/functionDefToTypeDef.dart';
import 'package:adi_helpers/testH.dart';

void main() {
  final fnDef1 = "f1<T>(int v1, T v2) → T";
  final fnDef2 = "f2(int v1, List<int> v2, int v3) → List<int>";
  final fnDef3 = "f3(int input) → void";
  final fnDef4 = "f4(String input) → int";
  final fnDef5 = "f5() → String";
  final fnDef6 = "f6((int, List<int>, int) → List<int> fn, int a) → List<int>";
  final fnDef7 = "f7(<T>(T, List<int>, int) → int fn, int a) → List<int>";

  group("functionDefToTypeDef", () {
    void exp_functionDefToTypeDef(String fnDef, String expected) =>
        expectGen(functionDefToTypeDef, fnDef, expected);

    test("functionDefToTypeDef1",
        () => exp_functionDefToTypeDef(fnDef1, "typedef fn_f1 = T Function<T>(int, T);"));
    test(
        "functionDefToTypeDef2",
        () => exp_functionDefToTypeDef(
            fnDef2, "typedef fn_f2 = List<int> Function(int, List<int>, int);"));
    test("functionDefToTypeDef3",
        () => exp_functionDefToTypeDef(fnDef3, "typedef fn_f3 = void Function(int);"));
    test("functionDefToTypeDef4",
        () => exp_functionDefToTypeDef(fnDef4, "typedef fn_f4 = int Function(String);"));
    test("functionDefToTypeDef5",
        () => exp_functionDefToTypeDef(fnDef5, "typedef fn_f5 = String Function();"));
    test(
        //f6((int, List<int>, int) → List<int> fn, int a) → List<int>
        "functionDefToTypeDef6",
        () => exp_functionDefToTypeDef(fnDef6,
            "typedef fn_f6 = List<int> Function(List<int> Function(int, List<int>, int), int);"));
    // test(
    //     //f7(<T>(T, List<int>, int) → int fn, int a) → List<int>
    //     "functionDefToTypeDef7",
    //     () => exp_functionDefToTypeDef(
    //         fnDef7, "typedef fn_f7 = List<int> Function<T>(T, List<int>, int);"));
  });

  group("functionName", () {
    void exp_functionName(String fnDef, String expected) =>
        expectGen(functionName, fnDef, expected);

    test("functionName1", () => exp_functionName(fnDef1, "fn_f1"));
    test("functionName2", () => exp_functionName(fnDef2, "fn_f2"));
  });

  group("genericDef", () {
    void exp_genericDef(String fnDef, String expected) => expectGen(genericDef, fnDef, expected);

    test("genericDef1", () => exp_genericDef(fnDef1, "<T>"));
    test("genericDef2", () => exp_genericDef(fnDef2, ""));
    test("genericDef3", () => exp_genericDef(fnDef3, ""));
    test("genericDef_a", () => exp_genericDef("f1<T1,T2>(int v1, T v2) → T1", "<T1,T2>"));
  });

  group("returnType", () {
    void exp_returnType(String fnDef, String expected) => expectGen(returnType, fnDef, expected);

    test("returnType1", () => exp_returnType(fnDef1, "T"));
    test("returnType2", () => exp_returnType(fnDef2, "List<int>"));
    test("returnType3", () => exp_returnType(fnDef3, "void"));
    test("returnType4", () => exp_returnType(fnDef4, "int"));
    test("returnType5", () => exp_returnType(fnDef5, "String"));
    test("returnType7", () => exp_returnType(fnDef7, "List<int>"));
    test("returnTypea", () => exp_returnType("(int, List<int>, int) → List<int> fn", "List<int>"));
  });

  group("fnDefToFnType", () {
    void exp_fnDefToFnType(String input, String expected) =>
        expectGen((x) => fnDefToFnType(x), input, expected);

    test(
        "fnDefToFnType1",
        () => exp_fnDefToFnType(
            "<T>(T, List<int>, int) → int fn", //
            "int Function<T>(T, List<int>, int)"));
    test(
        "fnDefToFnType2",
        () => exp_fnDefToFnType(
            "(int, List<int>, int) → List<int> fn", //
            "List<int> Function(int, List<int>, int)"));
  });

  group("splitParameters", () {
    void exp_splitParameters(String input, String expected) =>
        expectGen((x) => splitParameters(x).toString(), input, expected);

    test("splitParameters1", () => exp_splitParameters(fnDef1, "int, T"));
    test("splitParameters2", () => exp_splitParameters(fnDef2, "int, List<int>, int"));
    test("splitParameters3", () => exp_splitParameters(fnDef3, "int"));
    test("splitParameters4", () => exp_splitParameters(fnDef4, "String"));
    test("splitParameters5", () => exp_splitParameters(fnDef5, ""));
    test("splitParameters6",
        () => exp_splitParameters(fnDef6, "List<int> Function(int, List<int>, int), int"));
    // test(
    //     "splitParameters7",
    //     () => exp_splitParameters(
    //         fnDef7, "List<int> Function<T>(T, int Function(T, List<int>, int), int)"));

    test(
        "splitParametersa",
        () => exp_splitParameters(
            "fn_a((int, List<int>, int) → List<int> fn, int a) → int", //
            "List<int> Function(int, List<int>, int), int"));
    test(
        "splitParametersb",
        () => exp_splitParameters(
            "fn_b(String, (int, List<int>, int) → List<int> fn, int a) → String", //
            "String, List<int> Function(int, List<int>, int), int"));
  });
}
