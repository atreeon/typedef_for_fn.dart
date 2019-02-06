import 'package:typedef_for_fn/typedef_for_fn.dart';
part 'testFunction.g.dart';

@TypedefForFn()
T f1<T>(int v1, T v2) => v2;

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

// @TypedefForFn(name: "blah")
// int Function(String) f10(fn_f4 fn) => (String s) => 5;

@TypedefForFn(name: "blah")
int f11(int a) => a + 2;


// lastWordsLearntG(ArticleAndWordG _articleAndWordG, BatchType currentBatchType, ((List<UserLecture>, List<UserLesson>) → List<UserLectureUserLesson>, List<int>, List<UserLecture>, List<UserLesson>) → List<UserLectureUserLesson> userLectureUserLessonByLectureIds, (List<UserLecture>, List<UserLesson>) → List<UserLectureUserLesson> userLectureLessonsG, List<TestBatchItem> testBatchItems, List<LectureBatchItem> lectureBatchItems, List<Lecture> lectures, List<Translation> translations, List<UserLecture> userLectures, List<UserLesson> userLessons) → List<LastWordLearnt>

//at the moment generic function defintions don't work
// typedef fn_b = int Function<T>(T, List<int>, int);

// @TypedefForFn()
// List<int> f7(fn_b fn, int a) => [
//       fn(5, [1, 2], a)
//     ];
