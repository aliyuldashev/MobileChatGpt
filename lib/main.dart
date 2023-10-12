// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: chatInside(),
      theme: ThemeData().copyWith(
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.deepPurple[300],
              cursorColor: Colors.orangeAccent)),
      debugShowCheckedModeBanner: false,
    );
  }
}

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

String texts = '''
To display code blocks in Flutter, you can use the `Code` widget from the `flutter_highlight` package. Here's an example:
1. Add the `flutter_highlight` package to your `pubspec.yaml` file:
```
dependencies:
  flutter_highlight: ^0.6.0
```
2. Import the package in your Dart file:
```
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
```
3. Use the `Code` widget to display your code block:
```
Code(
  """
  // Your code here
  """,
  language: 'dart',
  style: githubTheme,
)
```
You can replace `dart` with the language of your choice, and `githubTheme` with any of the available themes from the `flutter_highlight` package.
''';

