import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add note',
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add),
        onPressed: (){
          debugPrint('add note pressed');
        },
      ),
    );
  }

  ListView getNoteList(){
    TextStyle titlestyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(

        itemCount: count,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.chevron_right
                ),),
              trailing: Icon(Icons.delete_outline),
              title: Text('dummy title',style: titlestyle,),
              subtitle: Text('dummy subtitle'),
              onTap: (){
                debugPrint('ontap pressed');
              },
            ),
          );
        } );
  }
}
