// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';

class chatOutside extends StatefulWidget {
  const chatOutside({super.key});

  @override
  State<chatOutside> createState() => _chatOutsideState();
}

class _chatOutsideState extends State<chatOutside> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar() ,
      body: SafeArea(child: Container(
      )),
      
    );
  }
}
