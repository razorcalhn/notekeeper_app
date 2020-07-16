import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDesc extends StatefulWidget {
  @override
  _NoteDescState createState() => _NoteDescState();
}

class _NoteDescState extends State<NoteDesc> {
  static var _priority = ['High','Low'];
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            DropdownButton(
              iconSize: 40,
              items: _priority.map((String stringitem){
                return DropdownMenuItem(
                  value: stringitem,
                  child: Text(stringitem,style: TextStyle(fontWeight: FontWeight.bold),),
                );
              }).toList(),
              value: 'Low',
              onChanged: (value){
                setState(() {
                  debugPrint('value selected by user is $value');
                });
              },
            ),
            SizedBox(height: 10.0,),
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                labelStyle: textStyle,
                labelText: 'Title',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5))
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                  labelStyle: textStyle,
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))
              ),
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
                      debugPrint('delete pressed');
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
}
