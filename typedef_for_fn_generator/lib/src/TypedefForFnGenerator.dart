import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';
import 'package:typedef_for_fn_generator/src/createTypeDef.dart';

class TypedefForFnGenerator extends GeneratorForAnnotation<TypedefForFn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var sb = StringBuffer();

    var childElements =
        element.unit.childEntities.map((x) => x.toString()).toList();

    sb.writeln("//" + element.displayName);
    sb.writeln(createTypeDef(element.displayName, childElements));

    return sb.toString();
  }
}

//Obsolete get data from code gen
// for (var item in childElements) {
//   sb.writeln("//" + item);
// }

// print("childElements retrieved");

// for (var i = 0; i < childElements.length; i++) {
//   sb.writeln("//$i$childElements[i]");
// }

// sb.writeln("//" + element.name);
// sb.writeln("//" + annotation.toString());
// sb.writeln("//" + element.toString());
// sb.writeln("//" + element.source.fullName);
// sb.writeln("//" + element.displayName);
// sb.writeln("//" + element.name);
// sb.writeln("//" + element.context.runtimeType.toString());
// sb.writeln("//6" + element.context.toString());
// sb.writeln("//7" + element.library.toString());
// sb.writeln("//8" + element.librarySource.toString());
// sb.writeln("//9" + element.source.toString());
// sb.writeln("//10" + element.unit.toSource());

//functionName = get name of function
//element.unit.childEntities.where(
//  substring 0,8 == @TypeddefForFn &&
//  split("/s")[3] == functionName)
//startFnIndx = firstCurlybrace || first =>
//substring(8, startFnIdx)

// sb.writeln("//" + element.unit.toString());
// sb.writeln("//" + element.unit.childEntities.skip(2).first.toString());

// for (var entity in element.unit.childEntities) {
//   sb.writeln("//" + entity.toString());
// }

// sb.writeln("//" + element.unit.beginToken.toString());

// sb.writeln("//" + element.kind.toString());
// sb.writeln("//" + element.name.toString());

// var childElements = element.unit.childEntities.map((x) {
//   // sb.writeln("//" + x.toString());
//   return x.toString();
// }).toList();
