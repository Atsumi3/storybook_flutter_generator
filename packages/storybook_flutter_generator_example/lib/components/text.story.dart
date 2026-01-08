import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_generator_annotation/storybook_flutter_generator_annotation.dart';

@GenerateStory()
Story textStory() => Story(
  name: 'Widgets/Text',
  description: 'Simple text widget.',
  builder: (context) => Center(child: Text('Simple text')),
);
