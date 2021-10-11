// ignore: import_of_legacy_library_into_null_safe
import 'package:build/build.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen/source_gen.dart';
import 'package:typedef_for_fn_generator/src/TypedefForFnGenerator.dart';

Builder typedefForFnBuilder(BuilderOptions options) => //
    PartBuilder([TypedefForFnGenerator()], '.typedef.dart',
        header: '''
    ''');
