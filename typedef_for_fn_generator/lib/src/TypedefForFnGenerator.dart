import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';

class TypedefForFnGenerator extends GeneratorForAnnotation<TypedefForFn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var sb = StringBuffer();

    var childElements =
        element.unit.childEntities.map((x) => x.toString()).toList();

//Obsolete get data from code gen
    for (var item in childElements) {
      sb.writeln("//" + item);
    }
    return sb.toString();
  }
}
