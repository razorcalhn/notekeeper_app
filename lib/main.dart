import 'package:flutter/material.dart';
import 'package:notekeeperapp/screens/note_list.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notekeeper',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: NoteList(),
    );
  }
}
