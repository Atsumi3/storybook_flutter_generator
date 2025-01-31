import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';

class StoryCollectorGenerator extends Generator {
  Future<String> generateMultiple(List<LibraryReader> libraries) async {
    final storyFunctions = <String>[];
    final imports = <String>{};

    /// 同一関数名があった場合に重複を防ぐためのカウンター
    int resourceCount = 0;

    for (var library in libraries) {
      /// 関数エレメントを取得し、その中でも [GenerateStory] があるものを抽出
      final storyElements =
          library.allElements.whereType<FunctionElement>().where(
                (e) => e.metadata.any(
                  (m) => m.element?.enclosingElement?.name == 'GenerateStory',
                ),
              );
      if (storyElements.isEmpty) {
        continue;
      }

      final resourceAlias = 'rs${++resourceCount}';
      storyElements.forEach((element) {
        final methodName = '${element.name}()';
        final importUri = element.source.uri.toString();
        if (importUri.startsWith('package:')) {
          imports.add("import '$importUri' as $resourceAlias;");
          storyFunctions.add('$resourceAlias.$methodName');
        } else {
          storyFunctions.add('$methodName');
        }
      });
    }

    return DartFormatter().format('''
      // GENERATED CODE - DO NOT MODIFY BY HAND
      import 'package:storybook_flutter/storybook_flutter.dart';

      ${imports.join('\n')}

      Iterable<Story> collectStories() {
        return [${storyFunctions.join(", ")},];
      }
    ''');
  }
}
