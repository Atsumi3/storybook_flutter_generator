import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import 'story_builder.dart';

const _generatedFileName = 'generated_stories.dart';

/// build_runner によって呼び出されるエントリーポイント
Builder storyCollectorBuilder(BuilderOptions options) =>
    StoryCollectorBuilder();

class StoryCollectorBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    r'$lib$': [_generatedFileName],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final generator = StoryCollectorGenerator();

    /// search .story.dart file
    final storyFiles = await buildStep
        .findAssets(Glob('**/*.story.dart'))
        .toList();

    /// load .story.dart file
    final loadAssetFuture = storyFiles.map(
      (assetId) => buildStep.resolver
          .libraryFor(assetId)
          .then((library) => LibraryReader(library)),
    );
    final libraryReaders = await Future.wait(loadAssetFuture);

    /// merged_stories.g.dart の内容を生成
    final generatedCode = await generator.generateMultiple(libraryReaders);

    /// 生成したコードを書き込む
    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/$_generatedFileName'),
      generatedCode,
    );
  }
}
