import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn/typedef_for_fn.dart';
import 'package:typedef_for_fn_generator/src/ElementForTypeDef.dart';
import 'package:typedef_for_fn_generator/src/createTypeDef.dart';

class TypedefForFnGenerator extends GeneratorForAnnotation<TypedefForFn> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var sb = StringBuffer();
    // sb.writeln("_${element.displayName}(){");

    if (element is FunctionElement) {
      // // sb.writeln("/*");
      // sb.writeln("ElementForTypeDef(");
      // element.documentationComment == null
      //     ? sb.writeln("null")
      //     : sb.writeln("\"${element.documentationComment}\",");
      // sb.writeln("\"${element.returnType}\",");
      // sb.writeln("\"${element.displayName}\",");
      // var typeParams = element.typeParameters
      //     .map((x) => "\"" + x.toString() + "\" ")
      //     .toList();
      // var parameters =
      //     element.parameters.map((x) => "\"" + x. .toString() + "\" ").toList();
      // sb.writeln(typeParams.toString() + ",");
      // sb.writeln(parameters.toString() + ",");
      // sb.writeln(");");
      // // sb.writeln("*/");

//islambda

// // // element.
// // //       sb.writeln("//${element.displayName}");
// // //       sb.writeln("/*");
// // //       sb.writeln("//" +
// // //           element.session
// // //               .getParsedLibraryByElement(element.library)
// // //               .units
// // //               .first
// // //               .content
// // //               .toString());
// // //       sb.writeln("*/");

      // sb.writeln("//" +
      // var bl = element.library.session
      //     .getParsedLibraryByElement(element.library)
      //     .units
      //     .map((x) => x.toString())
      //     .toList()
      //     .toString();
      // sb.writeln("//" + bl);

      // sb.writeln("//hello");
      // .map((x) => x.toString())
      // .toList()
      // .toString());
      // var parameters1 =
      //     element.parameters.map((x) => x.type.toString()).toList();
      // sb.writeln("//" + parameters1.toString());
      // sb.writeln("//" + element.parameters.toString());

      // ElementForTypeDef(
      //   element.documentationComment,
      //   element.returnType.toString(),
      //   element.displayName,
      //   element.typeParameters.map((x) => x.toString()),
      //   element.parameters.map((x) => x.toString()),
      // );

      // sb.writeln("//typeParameters:" + element.typeParameters.toString());
      // sb.writeln("//parameters:" + element.parameters.toString());
      // sb.writeln("//parameters:" + element.parameters.toString());
      // sb.writeln("//returnType:" + element.returnType.toString());
      // sb.writeln("//returnType:" + element.returnType.toString());
      // sb.writeln("//type:" + element.type.toString());
      // sb.writeln("//type:" + element.type.namedParameterTypes.toString());
      // sb.writeln("//type:" + element.type.optionalParameterTypes.toString());
    }
    // sb.writeln("}");

    // var childElements =
    //     element.unit.childEntities.map((x) => x.toString()).toList();

    // var childElements =
    //     element.unit.childEntities.map((x) => x.toString()).toList();

    // //uncomment to get lines of each function
    // // for (var entity in element.unit.childEntities) {
    // //   sb.writeln("//" + entity.toString());
    // // }
    // // sb.writeln("//" + element.name);
    // // sb.writeln("//" + annotation.toString());
    // // sb.writeln("//" + element.toString());
    // // sb.writeln("//" + element.source.fullName);
    // // sb.writeln("//" + element.displayName);
    // // sb.writeln("//" + element.name);
    // // sb.writeln("//" + element.context.runtimeType.toString());
    // // sb.writeln("//6" + element.context.toString());
    // // sb.writeln("//7" + element.library.toString());
    // // sb.writeln("//8" + element.librarySource.toString());
    // // sb.writeln("//9" + element.source.toString());
    // // sb.writeln("//10" + element.unit.toSource());
    // // if (element.documentationComment != null)
    // //   sb.writeln("//11" + element.documentationComment);

    String pre = null;
    if (!annotation.read('pre').isNull)
      pre = annotation.read('pre').stringValue;

    List<String> exNames = null;
    if (!annotation.read('exNames').isNull) {
      exNames = annotation
          .read('exNames')
          .listValue
          .map((x) => x.toStringValue())
          .toList();
    }

    //   sb.writeln("//" +
    //       element.session
    //           .getParsedLibraryByElement(element.library)
    //           .units
    //           .first
    //           .content
    //           .toString());

    // var childElements = element.library.session
    //     .getParsedLibraryByElement(element.library)
    //     .units
    //     .map((x) => x.toString())
    //     .toList();

    // sb.writeln("//" + childElements.toString());

    // // var childElements2 =
    // //     element.unit.childEntities.map((x) => x.toString()).toList();

    // sb.writeln("//" + element.displayName);
    sb.writeln(createTypeDef(
      element.displayName,
      element.session
          .getParsedLibraryByElement(element.library)
          .units
          .first
          .content
          .toString(),
      element.documentationComment,
      pre: pre,
      exNames: exNames,
    ));
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
