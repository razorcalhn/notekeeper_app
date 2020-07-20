import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:notekeeperapp/utils/database_helper.dart';
import 'package:notekeeperapp/main.dart';
import 'package:notekeeperapp/models/note.dart';

class NoteDesc extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  NoteDesc(this.note,this.appBarTitle);
  @override
  _NoteDescState createState() => _NoteDescState(this.note,this.appBarTitle);
}

class _NoteDescState extends State<NoteDesc> {
  static var _priority = ['High','Medium','Low'];
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String appBarTitle;
  Note note;
  _NoteDescState(this.note,this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    titleController.text=note.title;
    descriptionController.text=note.desc;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            DropdownButton(
              iconSize: 40,
              items: _priority.map((String stringItem){
                return DropdownMenuItem(
                  value: stringItem,
                  child: Text(stringItem,style: TextStyle(fontWeight: FontWeight.bold),),
                );
              }).toList(),
              value: priorityInText(note.priority),
              onChanged: (value){
                setState(() {
                  debugPrint('value selected by user is $value');
                  priorityInInt(value);
                });
              },
            ),
            SizedBox(height: 10.0,),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelStyle: textStyle,
                labelText: 'Title',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5))
              ),
                onChanged: (text){
                note.title = titleController.text;//check this later
                },
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))
              ),
              onChanged: (text){
                note.desc=descriptionController.text;// check this later
              },
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Save'),
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                      debugPrint('save pressed');
                      _save();
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: RaisedButton(
                    child: Text('Delete'),
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                      setState(() {
                        debugPrint('delete pressed');
                        _delete();
                      });
                    },
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }

  String priorityInText(int priority){
    switch(priority){
      case 0:
        return 'Low';
        break;
      case 1:
        return 'Medium';
        break;
      case 2:
        return 'High';
        break;
      default:
        return 'Medium';
    }
  }

  void priorityInInt(String s){
    switch(s){
      case 'High':
        note.priority = 2;
        break;
      case 'Medium':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 0;
        break;
      default:
        note.priority = 1;
    }
  }

  _save() async {
    Navigator.pop(context,true);//check this too

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if(note.id != null){
      result = await databaseHelper.updateNote(note);
    }
    else{
      result = await databaseHelper.insertNote(note);
    }

    if(result!=null){
      _showAlertDialogue('Note saved successfully');
    }
    else{
      _showAlertDialogue('Error saving note');
    }
  }

  _delete() async {
    Navigator.pop(context,true);
    if(note.id == null){
      _showAlertDialogue('you drunk or what?');
      return 0;
    }
    int result = await databaseHelper.deleteNote(note.id);
    
    if(result != null){
      _showAlertDialogue('Note deleted successfully');
    }
    else{
      _showAlertDialogue('Error occurred while deleting note');
    }

  }


  _showAlertDialogue(String s){
    AlertDialog alertDialogue = AlertDialog(
      title: Text('Status'),
      content: Text(s),

    );
    showDialog(
        context: context,
        builder: (_) => alertDialogue);
  }

}
