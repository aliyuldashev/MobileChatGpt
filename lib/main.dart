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

String texts = 'hello it is testing message';

