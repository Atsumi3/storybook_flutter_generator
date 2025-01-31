# storybook_flutter_generator

## Overview

`storybook_flutter_generator` is a tool that automatically consolidates Story files when using [`storybook_flutter`](https://github.com/ookami-kb/storybook_flutter).

This package helps manage your Storybook files efficiently by generating a single file that includes
all your stories, making it easier to maintain and use within your Flutter project.

## Features

- Automatically collects all Story files in a Flutter project.
- Generates a single Dart file that imports and registers all stories.
- Simplifies Storybook setup and management.

## Installation

Add `storybook_flutter_generator_builder` and `storybook_flutter_generator_annotation` to your
project's `pubspec.yaml`:

```yaml
dependencies:
  storybook_flutter_generator_annotation: latest_version

dev_dependencies:
  build_runner: any
  storybook_flutter_generator_builder: latest_version
```

Then run:

```sh
flutter pub get
```

## Usage

To generate a consolidated Story file, run:

```sh
dart run build_runner build
```

This will create a single Dart file containing all Story files found in your project.

### Example Output

```dart
// merged_stories.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:storybook_flutter/storybook_flutter.dart';

import 'package:storybook_flutter_generator_example/components/text.story.dart'
as rs1;
import 'package:storybook_flutter_generator_example/components/material.story.dart'
as rs2;
import 'package:storybook_flutter_generator_example/components/text2.story.dart'
as rs3;

Iterable<Story> collectStories() {
  return [
    rs1.textStory(),
    rs2.textStory(),
    rs3.text2Story(),
    rs3.textStory(),
  ];
}

```

Now you can use the generated file within your `storybook_flutter` setup.

```dart
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'merged_stories.g.dart';

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) =>
      Storybook(
        stories: collectStories(),
      );
}

```
