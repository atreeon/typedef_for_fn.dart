import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';

class TypedefForFnGenerator extends GeneratorForAnnotation<TypedefForFn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return "// Hey! Annotation found!";
  }
}