import 'package:flutter/material.dart';
import 'package:notekeeperapp/screens/note_list.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notekeeperapp/screens/view_note.dart';
import 'package:notekeeperapp/models/note.dart';
import 'package:notekeeperapp/screens/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  int id = 0;
  MyApp();
  MyApp.s(this.id);

  @override

  _MyAppState createState() => _MyAppState(this.id);
}

class _MyAppState extends State<MyApp> {



  @override
  int id = 0;

  _MyAppState(this.id);
  static Color color;
  List <Color> colorList =[Colors.blue,Colors.red,Colors.green,Colors.deepPurple,Colors.yellow];

  Widget build(BuildContext context) {
    color = colorList[id];
    MyApp().id = id;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notekeeper',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: NoteList(),
    );
  }

}


Note note = Note('example title', 2, 'example date','Your childhood Your childhood teacher did not wrong you when they taught you that there should be three, or four, or five sentences in a paragraph. It is important to understand, however, that the aim in teaching this was not to impart a hard-and-fast rule of grammar, drawn from an authoritative-but-dusty book. The true aim of this strategy was to teach you that your ideas must be well supported to be persuasive and effective. teacher did not wrong you when they taught you that there should be three, or four, or five sentences in a paragraph. It is important to understand, however, that the aim in teaching this was not to impart a hard-and-fast rule of grammar, drawn from an authoritative-but-dusty book. The true aim of this strategy was to teach you that your ideas must be well supported to be persuasive and effective.');
