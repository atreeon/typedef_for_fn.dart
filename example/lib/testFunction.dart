import 'package:example/A.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';

part 'testFunction.g.dart';

///This is a comment
@TypedefForFn()
T f1<T>(
  int v1,
  T v2,
) =>
    v2;

// @TypedefForFn()
// void f15() {
//   AWithAlias();
// }
