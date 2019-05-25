import 'package:flutter/material.dart';
import 'package:notes/NoteView.dart';
import 'package:notes/Settings.dart';

import 'package:notes/test.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/vors.jpg"), context);
    return MaterialApp(
      title: 'Fethi',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: new MyNotesPage(),
    );
  }
}

