import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:build/src/builder/build_step.dart';
import 'package:generator_common/GeneratorForAnnotationX.dart';
import 'package:generator_common/helpers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';

import 'createTypedefForFn.dart';

class TypedefForFnGenerator extends GeneratorForAnnotationX<TypedefForFn> {
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClasses,
  ) {
    var sb = StringBuffer();

    if (element is FunctionTypedElement) {
      var methodDetails = getMethodDetailsForFunctionType(
        element,
        (x) {},
      );

      sb.writeln(createTypedefForFn(methodDetails: methodDetails));
    }

    if (sb.length > 0) //
//      return "/*" + sb.toString() + "*/";
      return sb.toString();
    else //
      return "//Nothing to output, check if the annotation in on a function";
  }
}
