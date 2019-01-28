import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';
import 'package:typedef_for_fn_generator/src/functionDefToTypeDef.dart';

class TypedefForFnGenerator extends GeneratorForAnnotation<TypedefForFn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print(element.name);
    var sb = StringBuffer();
    // sb.writeln("//" + element.name);
    // sb.writeln("//" + annotation.toString());
    sb.writeln("//" + element.toString());
    sb.writeln(functionDefToTypeDef(element.toString()));

    return sb.toString();
  }
}
