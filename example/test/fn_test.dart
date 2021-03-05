import 'package:test/test.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';

part 'fn_test.g.dart';

main() {
  test("1", () {
    fn_f1 fn = <String>(int input, String str) => "blah" as String;

    var result = fn(1, "a");

    expect(result.toString(), "blah");
  });

  test("2", () {
    fn_f2 fn = (a, b, c) => [1, 2, 3];

    expect(fn(1, [2], 3).toString(), [1, 2, 3].toString());
  });

  test("3", () {
    fn_f3 fn = (a) => print("blah");
    fn(1);
  });

  test("4", () {
    fn_f4 fn = (String a) => 5;
    expect(fn("blah").toString(), "5");
  });

  test("5", () {
    fn_f5 fn = () => "5";
    expect(fn().toString(), "5");
  });

  test("6", () {
    fn_a fna = (a, b, c) => [1, 2, 3];

    fn_f6 fn = (a, b) => [1, 2, 3];
    var result = fn(fna, 5);

    expect(result.toString(), "[1, 2, 3]");
  });

  test("7", () {
    fn_b fna = () => 5;

    fn_f7 fn = (a) => 5;
    var result = fn(fna);

    expect(result.toString(), "5");
  });

  test("8", () {
    fn_a fna = (a, b, c) => [1, 2, 3];

    fn_f8 fn = (a, b) => [1, 2, 3];
    var result = fn(fna, 5);

    expect(result.toString(), "[1, 2, 3]");
  });

  test("9", () {
    fn_f4 fn4 = (a) => 99;

    fn_f9 fn = (a, b) => 5;
    var result = fn(fn4, 88);

    expect(result.toString(), "5");
  });

//  test("11", () {
//    blahf11 _blahf11 = (a) => 5;
//    var result = _blahf11(99);
//
//    expect(result.toString(), '5');
//  });
//
//  test("12", () {
//    fn_f12 fn = () => 5;
//    var result = fn();
//
//    expect(result.toString(), '5');
//  });
//
//  test("13", () {
//    fn_f13 fn = <String>(a, {required d}) => 5;
//    var result = fn("blah", d: "blim");
//
//    expect(result.toString(), '5');
//  });
//
//  test("13b", () {
//    fn_f13b fn = <String>(a, {d}) => 5;
//    var result = fn("blah");
//
//    expect(result.toString(), '5');
//  });
//
//  test("14", () {
//    fn_f14 fn = () => "a";
//    var result = fn();
//
//    expect(result.toString(), 'a');
//  });
//
//  test("16", () async {
//    fn_f16 fn = <String>(a, {required d}) => //
//        Future<int>.value(5);
//    var result = await fn("blah", d: "blim");
//
//    expect(result.toString(), '5');
//  });
//
//  //couldn't get this to compile
//  test("17b", () async {
//    fn_f17b fn = <T>(String a, {T? d}) => //
//        Future<int>.value(5);
//
//    var resultx = await fn("1", d: "blah");
//
//    expect(resultx.toString(), '5');
//  });
}

//POTENTIAL OTHER TESTS

//https://github.com/dart-lang/language/issues/1418#issuecomment-767024163
//fn_fx a = <T>(int c, T d) => d;
//fn_fy b = <T>(String c, T d) => d;
//fn_fz c = <T>(String c, T d) => 42;

//typedef fn_fx = T Function<T>(int c, T d);
//
//typedef fn_fy = T Function<T>(String c, T d);
//
//typedef fn_fz = int Function<T>(String c, T d);
//
//typedef fn_fxn = T Function<T>(int c, T? d);
//
//typedef fn_fyn = T Function<T>(String c, T? d);
//
//typedef fn_fzn = int Function<T>(String c, T? d);
//
//typedef fn_fxp = T Function<T>(int c, {T d});
//
//typedef fn_fyp = T Function<T>(String c, {T d});
//
//typedef fn_fzp = int Function<T>(String c, {T d});
//
//typedef fn_fxpr = T Function<T>(int c, {required T d});
//
//typedef fn_fypr = T Function<T>(String c, {required T d});
//
//typedef fn_fzpr = int Function<T>(String c, {required T d});

////obsoleted levels
//// @TypedefForFn(pre: "blah", levels: 1)
//// int Function(String) f10(fn_f4 fn) => (String s) => 5;

///This is a comment
@TypedefForFn()
T f1<T>(
  int v1,
  T v2,
) {
  return v2;
}

@TypedefForFn()
List<int> f2(int v1, List<int> v2, int v3) => v2.where((x) => x > 5).toList();

@TypedefForFn()
void f3(int input) {}

@TypedefForFn()
int f4(String input) => 5;

@TypedefForFn()
String f5() => "blah";

typedef fn_a = List<int> Function(int, List<int>, int);

@TypedefForFn()
List<int> f6(fn_a fn, int a) => fn(5, [1, 2], a);

typedef fn_b = int Function();

@TypedefForFn()
int f7(fn_b fn) => 1;

@TypedefForFn()
List<int> f8(fn_a fn, int a) {
  return fn(5, [1, 2], a);
}

@TypedefForFn()
int f9(fn_f4 fn, int a) {
  return fn("blah") + 2;
}

//@TypedefForFn(pre: "blah")
//int f11(int a) => a + 2;
//
//@TypedefForFn(exNames: ["a", "b"])
//int f12(int a, String b) => a + 2;
//
//@TypedefForFn(exNames: ["a", "b"])
//int f13<T>(int a, Map<int, String> b, String c, {required T d}) => a + 2;
//
//@TypedefForFn(exNames: ["a", "b"])
//int f13b<T>(int a, Map<int, String> b, String c, {T? d}) => a + 2;
//
//@TypedefForFn(exNames: ["a"])
//String f14(Map<String, int> a) => "blah";
//
//@TypedefForFn(exNames: ["a", "b"])
//Future<int> f16<T>(int a, Map<int, String> b, String c, {required T d}) async =>
//    a + 2;
//
//@TypedefForFn(exNames: ["a", "b"])
//Future<int> f16b<T>(int a, Map<int, String> b, String c, {T? d}) async => a + 2;
//
//@TypedefForFn(exNames: ["a", "b"])
//Future<int> f17<T>(int a, Map<int, String> b, String c, {required T d}) async {
//  return a + 2;
//}
//
//@TypedefForFn(exNames: ["a", "b"])
//Future<int> f17b<T>(int a, Map<int, String> b, String c, {required T? d}) async {
//  return a + 2;
//}
//
//@TypedefForFn()
//String formatHello(Person person) {
//  return "${person.name} has pressed the counter ${person.counter} times";
//}
//
//class Person {
//  final String name;
//  final int counter;
//
//  Person({
//    required this.name,
//    required this.counter,
//  });
//}
