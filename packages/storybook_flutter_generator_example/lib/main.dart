import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'merged_stories.g.dart';

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) => Storybook(
        stories: collectStories(),
      );
}
