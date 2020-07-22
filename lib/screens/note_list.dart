import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:notekeeperapp/utils/database_helper.dart';
import 'package:notekeeperapp/main.dart';
import 'package:notekeeperapp/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'package:notekeeperapp/screens/about.dart';
import 'package:notekeeperapp/screens/view_note.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count=0;
  List<Note> noteList;
  var random = Random();
  @override
  Widget build(BuildContext context) {
    if (noteList == null){
      noteList = List<Note>();
      updateListView();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(7,13,0,4),
          child: Text('Notekeeper'.toUpperCase(),style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
            letterSpacing: 1.5,
          ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,3,3),
            child: IconButton(icon: Icon(Icons.info,color: Theme.of(context).primaryColorDark),
            iconSize: 32,
            onPressed: (){
              debugPrint('info working fine');
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutApp()));
            },),
          )
        ],
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,10),

            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: Container(
                  color: Colors.white,
                    child: listViewNoteList())
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        tooltip: 'Add note',
        backgroundColor: Theme.of(context).primaryColorDark,
        icon: Icon(Icons.add),
        label: Text('ADD NOTE'),
        onPressed: (){
          debugPrint('add note pressed');
          gotoNoteDescription(Note('',1,''),'Add Note');
        },
      ),
    );
  }

  ListView listViewNoteList(){
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    List<String> colorList=['s'];
    return ListView.builder(
      physics: BouncingScrollPhysics(),

        itemCount: count,
        itemBuilder: (BuildContext context, int position){
        int colorNum = random.nextInt(18);
        Color shadowColor = Colors.primaries[colorNum];
        Color noteColor = Colors.primaries[colorNum][50];

          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: noteColor, width: 1)
              ),
              shadowColor: shadowColor,
              elevation: 5,
              color: noteColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getNoteColor(noteList[position].priority),//if not work change to this.notelist
                  child: Icon(getNoteIcon(noteList[position].priority),
                  ),
                ),
                trailing: GestureDetector(
                    child: Icon(Icons.delete_outline),
                        onTap: (){
                      _deleteNote(context,noteList[position]);
                  },
                ),
                title: Text(noteList[position].title,style: titleStyle,),
                subtitle: Text(noteList[position].date),
                onTap: () async {
                  debugPrint('ontap pressed');
                  //gotoNoteDescription(noteList[position],'Edit Note');
                  await gotoViewNote(noteList[position]);
                  updateListView();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNote(noteList[position])));
                },
              ),
            ),
          );
        } );
  }
  void gotoNoteDescription(Note note,String title) async {
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context)=> NoteDesc(note,title)));
    if(result ==true)//not necessary to add a bool check.We'll need to update the listview nevertheless after popping the detail page.
    {
      updateListView();
    }
  }

  void gotoViewNote(Note note) async {
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context)=> ViewNote(note)));
    if(result ==true){//not necessary to add a bool check.We'll need to update the listview nevertheless after popping the detail page.
      updateListView();}
  }


  /*void updateListView() async {
    var db = await databaseHelper.database;
    List<Note> noteList = await databaseHelper.getNoteList();
    setState(() {
      this.noteList=noteList;
      this.count=noteList.length;
    });
  }*/
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDb();
    dbFuture.then((database) {
      var noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  Color getNoteColor(int priority){
    var color;
    switch(priority){
      case 0:
        color= Colors.yellow;
        break;
      case 1:
        color=Colors.deepOrange[400];
        break;
      case 2:
        color = Colors.red;
        break;
    }
    return color;
  }

  IconData getNoteIcon(int priority){
    switch (priority){
      case 0:
        return Icons.keyboard_arrow_right;
        break;

      case 1:
        return Icons.arrow_forward;
        break;

      case 2:
        return Icons.priority_high;
        break;

      default:
        return Icons.keyboard_arrow_right;
    }
  }

  void _deleteNote(BuildContext context,Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if(result != null){
      _showSnackBar(context,'Note deleted successfully');
      updateListView();

    }
    else{
      _showSnackBar(context,'Error deleting note');
    }
  }

  void _showSnackBar(BuildContext context,String message){
    final snackBar = SnackBar(content: Text(message),
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black38,);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {

    return BoxShadow(
        color:  color.withAlpha(60),
        blurRadius: 8,
        offset: Offset(0, 8));
  }


}

