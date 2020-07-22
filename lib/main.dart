import 'package:flutter/material.dart';
import 'package:notekeeperapp/screens/note_list.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notekeeperapp/screens/view_note.dart';
import 'package:notekeeperapp/models/note.dart';

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

Note note = Note('example title', 2, 'example date','Your childhood Your childhood teacher did not wrong you when they taught you that there should be three, or four, or five sentences in a paragraph. It is important to understand, however, that the aim in teaching this was not to impart a hard-and-fast rule of grammar, drawn from an authoritative-but-dusty book. The true aim of this strategy was to teach you that your ideas must be well supported to be persuasive and effective. teacher did not wrong you when they taught you that there should be three, or four, or five sentences in a paragraph. It is important to understand, however, that the aim in teaching this was not to impart a hard-and-fast rule of grammar, drawn from an authoritative-but-dusty book. The true aim of this strategy was to teach you that your ideas must be well supported to be persuasive and effective.');
