import 'package:example/A.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';
part 'testFunction.g.dart';

///This is a comment
@TypedefForFn()
T f1<T>(
  int v1,
  T v2,
) {
  return v2;
}

@TypedefForFn()
List<int> f2(int v1, List<int> v2, int v3) =>
    List().where((x) => x > 5).toList();

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
int f7(fn_b fn) => 1;

@TypedefForFn()
List<int> f8(fn_a fn, int a) {
  return fn(5, [1, 2], a);
}

@TypedefForFn()
int f9(fn_f4 fn, int a) {
  return fn("blah") + 2;
}

@TypedefForFn(pre: "blah")
int f11(int a) => a + 2;

@TypedefForFn(exNames: ["a", "b"])
int f12(int a, String b) => a + 2;

@TypedefForFn(exNames: ["a", "b"])
int f13<T>(int a, Map<int, String> b, String c, {T d}) => a + 2;

@TypedefForFn(exNames: ["a"])
String f14(Map<String, int> a) => "blah";

@TypedefForFn()
void f15() {
  AWithAlias();
}

@TypedefForFn(exNames: ["a", "b"])
Future<int> f16<T>(int a, Map<int, String> b, String c, {T d}) async => a + 2;

@TypedefForFn(exNames: ["a", "b"])
Future<int> f17<T>(int a, Map<int, String> b, String c, {T d}) async {
  return a + 2;
}

//obsoleted levels
// @TypedefForFn(pre: "blah", levels: 1)
// int Function(String) f10(fn_f4 fn) => (String s) => 5;
