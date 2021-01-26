import 'package:dartz/dartz.dart';
import "package:test/test.dart";
import 'package:typedef_for_fn_generator/src/createTypeDef.dart';

import 'createTypeDef_testData.dart';
import 'createTypeDef_testData2.dart';

void main() {
  // final codeLines = [
  //   "import 'package:typedef_for_fn/typedef_for_fn.dart';",
  //   "@TypedefForFn() T f1<T>(int v1, T v2) => v2;",
  //   "@TypedefForFn() List<int> f2(int v1, List<int> v2, int v3) => List();",
  //   "@TypedefForFn() void f3(int input) {}",
  //   "@TypedefForFn() int f4(String input) => 5;",
  //   "@TypedefForFn() String f5() => \"blah\";",
  //   "typedef fn_a = List<int> Function(int, List<int>, int)",
  //   "@TypedefForFn() List<int> f6(fn_a fn, int a) => fn(5, [1, 2], a);",
  //   "@TypedefForFn() List<int> f8(fn_a fn, int a) {fn(5, [1, 2], a);}",
  //   // "@TypedefForFn(name: "
  //   //     "blah"
  //   //     ") int Function(String) f10(fn_f4 fn) => (String s) => 5;",
  //   "@TypedefForFn(name: \"blah\") int f11(int a) => a + 2;",
  //   "@TypedefForFn(exNames: [\"a\", \"b\"]) int f12(int a, String b) => a + 2;",
  //   "@TypedefForFn(exNames: [\"a\", \"b\"]) int f13<T>(int a, Map<int, String> b, String c, {T d}) => a + 2;",
  //   "@TypedefForFn(exNames: [\"a\"]) String f14(Map<String, int> a) => \"blah\";",
  // ];

//  final fullFn1 = r"@TypedefForFn() T f1<T>(int v1, T v2) => v2;";
//  final fullFn2 = r"@TypedefForFn() List<int> f2(int v1, List<int> v2, int v3) => List()";
//  final fullFn3 = "@TypedefForFn() List<int> f8(fn_a fn, int a) {fn(5, [1, 2], a);}";
//  final fullFn4 = "@TypedefForFn() List<int> f8(fn_a fn, int a) async {fn(5, [1, 2], a);}";
//
//  final fnDef1 = r"T f1<T>(int v1, T v2)";
//  final fnDef2 = r"List<int> f2(int v1, List<int> v2, int v3)";
//  final fnDef3 = r"List<int> f8(fn_a fn, int a)";

  group("createTypeDef", () {
    void exp_createTypeDef(String fnName, String expected, {String pre, List<String> exNames}) {
      var result = createTypeDef(fnName, testCodeLinesInput, null, preInput: pre, exNamesInput: exNames);
      expect(result, expected);
    }

    test("1", () => exp_createTypeDef("f1", "typedef fn_f1 = T Function<T>( int v1, T v2, );"));
    test("2", () => exp_createTypeDef("f2", "typedef fn_f2 = List<int> Function(int v1, List<int> v2, int v3,);"));
    test("3", () => exp_createTypeDef("f3", "typedef fn_f3 = void Function(int input,);"));
    test("4", () => exp_createTypeDef("f4", "typedef fn_f4 = int Function(String input,);"));
    test("5", () => exp_createTypeDef("f5", "typedef fn_f5 = String Function();"));
    test("6", () => exp_createTypeDef("f6", "typedef fn_f6 = List<int> Function(fn_a fn, int a,);"));
    test("8", () => exp_createTypeDef("f8", "typedef fn_f8 = List<int> Function(fn_a fn, int a,);"));
    test("11", () => exp_createTypeDef("f11", "typedef blah_f11 = int Function(int a,);", pre: "blah_"));
    test("12", () => exp_createTypeDef("f12", "typedef fn_f12 = int Function();", exNames: ["a", "b"]));
    test("13", () => exp_createTypeDef("f13", "typedef fn_f13 = int Function<T>(String c, {T d});", exNames: ["a", "b"]));

    test("14", () => exp_createTypeDef("f14", "typedef fn_f14 = String Function();", exNames: ["a"]));

    test("16", () => exp_createTypeDef("f16", "typedef fn_f16 = Future<int> Function<T>(String c, {T d});", exNames: ["a", "b"]));

    test("17", () => exp_createTypeDef("f17", "typedef fn_f17 = Future<int> Function<T>(String c, {T d});", exNames: ["a", "b"]));

    test("getFirebaseData", () {
      var result = createTypeDef("getFirebaseData", testCodeLinesInput2, null, exNamesInput: ["firebaseDb"]);
      expect(result, "typedef fn_getFirebaseData = Future<int> Function<T>(String uid, String collectionType, bool isStaticData);");
    });
  });

  group("addCommaToEndOfParameters", () {
    void eAddCommaToEndOfParameters(String line, String expected) {
      var result = addCommaToEndOfParameters(line);
      expect(result, expected);
    }

    test(
        "1",
        () => eAddCommaToEndOfParameters(
              "fn_f1 = T Function<T>(int v1, T v2,)",
              "fn_f1 = T Function<T>(int v1, T v2,)",
            ));

    test("2", () => eAddCommaToEndOfParameters("List<int> f2(int v1, List<int> v2, int v3)", "List<int> f2(int v1, List<int> v2, int v3,)"));
  });

  group("getFnSignatureFromCodeLine", () {
    void eGetFnSignatureFromCodeLine(String line, String expected) {
      var result = getFnSignatureFromCodeLine(line);
      expect(result, expected);
    }

    test(
        "1",
        () => eGetFnSignatureFromCodeLine(
              "@TypedefForFn() T f1<T>( int v1, T v2, ) { return v2; }",
              "T f1<T>( int v1, T v2, )",
            ));

    test(
        "2",
        () => eGetFnSignatureFromCodeLine(
              "@TypedefForFn(exNames: [\"a\", \"b\"]) Future<int> f16<T>(int a, Map<int, String> b, String c, {T d}) async => a + 2;",
              "Future<int> f16<T>(int a, Map<int, String> b, String c, {T d})",
            ));

    test(
        "3",
        () => eGetFnSignatureFromCodeLine(
              """
              @TypedefForFn(exNames: ["a", "b"])
Future<int> f17<T>(int a, Map<int, String> b, String c, {T d}) async { 
  return a + 2;
}""",
              "Future<int> f17<T>(int a, Map<int, String> b, String c, {T d})",
            ));
  });

  group("getFunctionSignature", () {
    void eGetFunctionSignature(String fnName, String expected) {
      var result = getFunctionSignature(testCodeLinesInput, fnName);
      expect(result, expected);
    }

    test("1", () => eGetFunctionSignature("f1", "T f1<T>( int v1, T v2, )"));
    test("2", () => eGetFunctionSignature("f2", "List<int> f2(int v1, List<int> v2, int v3)"));
    test("3", () => eGetFunctionSignature("f3", "void f3(int input)"));
    test("4", () => eGetFunctionSignature("f4", "int f4(String input)"));
    test("5", () => eGetFunctionSignature("f5", "String f5()"));
    test("6", () => eGetFunctionSignature("f6", "List<int> f6(fn_a fn, int a)"));
    test("8", () => eGetFunctionSignature("f8", "List<int> f8(fn_a fn, int a)"));
    test("9", () => eGetFunctionSignature("f9", "int f9(fn_f4 fn, int a)"));
    test("11", () => eGetFunctionSignature("f11", "int f11(int a)"));
    test("12", () => eGetFunctionSignature("f12", "int f12(int a, String b)"));
    test("13", () => eGetFunctionSignature("f13", "int f13<T>(int a, Map<int, String> b, String c, {T d})"));
    test("14", () => eGetFunctionSignature("f14", "String f14(Map<String, int> a)"));
    test("15", () => eGetFunctionSignature("f15", "void f15()"));
  });

  group("isLambda", () {
    void eIsLambda(String codeLine, Option<bool> expected) {
      var result = isLambda(codeLine);
      expect(result, expected);
    }

    test("1 lambda", () {
      eIsLambda("List<int> f2(int v1, List<int> v2, int v3) => List().where((x) => x > 5).toList();", some(true));
    });

    test("2 not a real function", () {
      eIsLambda("List<int> f2(int v1, List<int> v2, int v3) sdlkfj lskdj not a real function definition;", none());
    });

    test("3 just brackets", () {
      eIsLambda("List<int> f8(fn_a fn, int a) { return fn(5, [1, 2], a);", some(false));
    });

    test("4 internal lambda", () {
      eIsLambda("List<int> f8(fn_a fn, int a) { () => return x));", some(false));
    });

    test("5 internal function ", () {
      eIsLambda("List<int> f8(fn_a fn, int a) => return {blah};", some(true));
    });

    test("5 internal function ", () {
      eIsLambda("int f13<T>(int a, Map<int, String> b, String c, {T d}) => a + 2;", some(true));
    });
  });

  group("rmParamsFromFnSignature", () {
    void eRmParamsFromFnSignature(String fn, List<String> exNames, String expected) {
      var result = rmParamsFromFnSignature(fn, exNames);
      expect(result, expected);
    }

    test("1", () {
      eRmParamsFromFnSignature("int Function(int a, String b)", [], "int Function(int a, String b)");
    });
    test("2", () {
      eRmParamsFromFnSignature("int Function(int a, String b)", ["b"], "int Function(int a)");
    });
    test("3", () {
      eRmParamsFromFnSignature("int Function(String a, List<String> b, {String c, List<String> d})", ["a"], "int Function(List<String> b, {String c, List<String> d})");
    });

    test("4", () {
      eRmParamsFromFnSignature("int Function(Map<int, String> a, String b)", ["b"], "int Function(Map<int, String> a)");
    });
  });

  group("getParameters", () {
    void exp_getParameters(String fn, Map<String, String> expected) {
      var result = getParameters(fn);
      expect(result.toString(), expected.toString());
    }

    test("1", () => exp_getParameters("int Function(int a, String b)", {"a": "int", "b": "String"}));
    test("2", () => exp_getParameters("int Function(Map<int, String> a, String b)", {"a": "Map<int, String>", "b": "String"}));

    test("3", () => exp_getParameters("int Function(String a, List<String> b, {String c, List<String> d})", {"a": "String", "b": "List<String>", "c": "{String", "d}": "List<String>"}));

    test("4", () => exp_getParameters("int Function()", {}));
  });
}

//Obsolete, old code

// group("getFnDef", () {
//   void exp_getFnDef(String fullFn, String expected) {
//     var result = getFnDef(fullFn);
//     expect(result, expected);
//   }

//   var fullFn11 = "@TypedefForFn(name: " "blah" ") int f11(int a) => a + 2;";
//   var fnDef11 = "int f11(int a)";

//   test("1", () => exp_getFnDef(fullFn1, fnDef1));
//   test("2", () => exp_getFnDef(fullFn2, fnDef2));
//   test("3", () => exp_getFnDef(fullFn3, fnDef3));
//   test("11", () => exp_getFnDef(fullFn11, fnDef11));
//   test(
//       "13",
//       () => exp_getFnDef(
//           "@TypedefForFn(exNames: [\"a\", \"b\"]) int f13<T>(int a, Map<int, String> b, String c, {T d}) => a + 2;",
//           "int f13<T>(int a, Map<int, String> b, String c, {T d})"));
//   test(
//       "a",
//       () => exp_getFnDef(
//           "@meta1() @meta2() int fa({a}) => a + 2;", "int fa({a})"));
// });

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
