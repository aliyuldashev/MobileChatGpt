import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final translator = GoogleTranslator();

Future<String> generateGpt(String prompt, List data) async {
  const apiKey = 'YOUR_OWN_APIKEY';


  var url = Uri.https("api.openai.com", "/v1/chat/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "gpt-3.5-turbo",
      "messages": data,
      'temperature': 0,
      'max_tokens': 2000,
      'top_p': 1,
      'frequency_penalty': 0.0,
      'presence_penalty': 0.0,
    }),
  );

// Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['message']['content'];
}

generateResponse(String promt,List list) async {
  List promts = [];
  for(var items in list){
    promts.add({
      'role':items.chatMessageType,
      'content':items.text,
    });
  }
  // String enginput = await translateinput(promt);
  String textGpt = await generateGpt(promt, promts);
  // var val = await spliterCode(textGpt.toString());
  return textGpt.toString();
}

spliterCode(String text) async {
  RegExp regex = RegExp(r"```(.*?)```", multiLine: true, dotAll: true);
  List codeBlock =
      regex.allMatches(text).toList().map((match) => match.group(0)).toList();
  for (String code in codeBlock) {
    text = text.replaceFirst(code, "  1.1.1.1.${codeBlock.indexOf(code)}  ");
  }

  var translations = await translator.translate(text, from: 'en', to: 'uz');
  String trans = translations.text;
  for (String code in codeBlock) {
    trans = trans.replaceFirst("1.1.1.1.${codeBlock.indexOf(code)}", code);
  }
  return {'text': trans};
}

Future<String> translateinput(String input) async {
  var translations = await translator.translate(input, from: 'uz', to: 'en');
  String trans = translations.text;
  return trans;
}


Color kback = Color.fromRGBO(239, 240, 244, 255);

Color kpost = Colors.white;

TextStyle kchatname = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    fontSize: 20);

TextStyle kpostTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontFamily: 'Roboto',
    fontSize: 20);

TextStyle kpostText =
    TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 20);

TextStyle kcommentText =
    TextStyle(color: Colors.grey[400], fontFamily: 'Roboto', fontSize: 12);

Color ksecandary = Color.fromRGBO(208, 210, 222, 255);


