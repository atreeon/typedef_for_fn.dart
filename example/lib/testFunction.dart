import 'package:example/BatchItemTest.dart';
import 'package:example/Score.dart';
import 'package:example/TestType.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';
part 'testFunction.g.dart';

///This is a comment
@TypedefForFn()
T f1<T>(
  int v1,
  T v2,
) =>
    v2;

@TypedefForFn()
List<int> f2(int v1, List<int> v2, int v3) => List();

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

@TypedefForFn(exNames: [
  "testTypeForStage",
  "totalSeconds",
  "blims",
  "fB",
])
List<BatchItemTest> f15(
  fn_testTypeForStage testTypeForStage,
  int totalSeconds,
  Map<int, int> testTypeInfos,
  fn_fB fB,
  List<String> userLectureLessons,
) {
  var i = 0;
  var seconds = 0;
  var batchItems = List<BatchItemTest>();
  while (seconds < totalSeconds && i < userLectureLessons.length) {
    var dueTest = userLectureLessons[i];
    var testType = testTypeForStage(dueTest);

    var testTypeInfo = testTypeInfos[testType];

    seconds += testTypeInfo;
    //TODO: for some reason this line of code kills build_runner!
    //  might have to rewrite this function differently???
        var batchItem = BatchItemTest([999], true,
        ScoreStaged(testType, 546, 321));

    batchItems.add(batchItem);

    i++;
  }

  return batchItems;
}

typedef fn_testTypeForStage = TestType Function(String);
typedef fn_fB = int Function(int);

//obsoleted levels
// @TypedefForFn(pre: "blah", levels: 1)
// int Function(String) f10(fn_f4 fn) => (String s) => 5;
