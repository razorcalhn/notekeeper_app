import 'package:flutter/cupertino.dart';
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
        elevation: 0,
        title: Text(appBarTitle,style: TextStyle(color: Theme.of(context).primaryColorDark,fontFamily: 'JosefinSans',),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Notes with higher priority\nwill be on top',
                    style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 1,

                    ),),
                  DropdownButton(
                    iconSize: 55,
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
                ],
              ),
              SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))
                  ),
                    onChanged: (text){
                      note.title = titleController.text;//check this later
                      debugPrint('note desc wala onchanged   $titleController.text');

                    },
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))
                  ),
                  onChanged: (text){
                    note.desc=descriptionController.text;// check this later
                    debugPrint('note desc wala onchanged   $descriptionController.text');
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 140,
                    child: RaisedButton(
                      child: Text('Save',style: TextStyle(fontSize: 20,fontFamily: 'JosefinSans',letterSpacing: 1)),
                      color: Theme.of(context).accentColor,
                      textColor:Colors.white ,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ) ,
                      onPressed: (){
                        debugPrint('save pressed');
                        titleController.text != '' ? _save() : debugPrint('cant delete nothing');
                        //_save();
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    height: 50,
                    width: 140,
                    child: RaisedButton(
                      child: Text('Delete',style: TextStyle(fontSize: 20,fontFamily: 'JosefinSans',letterSpacing: 1),),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        onPressed: (){
                        setState(() {
                          debugPrint('delete pressed');
                          note.id != null ? _showAlertDialogue() : debugPrint('cant delete empty');
                        });
                      },
                    ),
                  ),

                ],
              )

            ],
          ),
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
    //Navigator.pop(context,true);//check this too
    debugPrint('_save' + note.title);
    //debugPrint('_save' + note.desc);
    note.date = DateFormat.yMMMd().add_jm().format(DateTime.now());
    int result;
    if(note.id != null){
      result = await databaseHelper.updateNote(note);
    }
    else{
      result = await databaseHelper.insertNote(note);
    }

    if(result!=null){
      debugPrint('saved succ');
    }
    else{
      debugPrint('not savedd');
    }
    int count = 0;
    await Navigator.pop(context,true);
    //Navigator.pop(context,true); //just so is goes to first page

  }

  _delete() async {
    //Navigator.pop(context,true);

    if(note.id == null){
      debugPrint('wrong action not empty');
      return 0;
    }
    //int result = await databaseHelper.deleteNote(note.id);

    //bool result = _showAlertDialogue();
    //debugPrint(result.toString());


    int deleteConf = await databaseHelper.deleteNote(note.id);
    deleteConf != null ? debugPrint('deleted!') : debugPrint('not deleted someproblem in db');
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 3;
    });

  }


  _showAlertDialogue(){
    AlertDialog alertDialogue = AlertDialog(
      title: Text('Status'),
      content: Text('This note will be permanently deleted,\ncontinue?'),
      actions: <Widget>[
        FlatButton(
          child: Text('YES'),
          onPressed: (){
            debugPrint('presses yes on alertbox');
            _delete();
            //return true;
          },
        ),
        FlatButton(
          child: Text('NO'),
          onPressed: (){
            debugPrint('user pressed no on alertbox');
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 3;
            });
          },
        )
      ],

    );
    showDialog(
        context: context,
        builder: (_) => alertDialogue);
  }

}
