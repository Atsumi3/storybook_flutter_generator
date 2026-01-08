import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_generator_annotation/storybook_flutter_generator_annotation.dart';

@GenerateStory()
Story text2Story() => Story(
  name: 'Widgets/Text',
  description: 'Simple text widget. 2',
  builder: (context) => Center(child: Text('Simple text')),
);

@GenerateStory()
Story textStory() => Story(
  name: 'Widgets/Text',
  description: 'Simple text widget. 3',
  builder: (context) => Center(child: Text('Simple text')),
);
