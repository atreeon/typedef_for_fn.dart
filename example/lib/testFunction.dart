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
