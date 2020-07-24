import 'package:flutter/material.dart';
import 'package:notekeeperapp/screens/note_list.dart';
import 'package:notekeeperapp/screens/note_description.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notekeeperapp/screens/view_note.dart';
import 'package:notekeeperapp/models/note.dart';
import 'package:notekeeperapp/screens/about.dart';
import 'package:provider/provider.dart';
import 'package:notekeeperapp/utils/theme_changer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i;
  List <Color> colorList =[Colors.blue,Colors.red,Colors.green,Colors.deepPurple,Colors.yellow];


  @override

  void initState() {
    super.initState();
    debugPrint('super init state ran');
    updateFromSP();
  }



  Widget build(BuildContext context)  {

    return ChangeNotifierProvider <ThemeChanger>(
      create: (_) {
        debugPrint('create (_) ran ' + i.toString());
        return ThemeChanger(ThemeData(primarySwatch: colorList[i]));},
      child: MaterialAppWithTheme(),
    );
  }


  void setNum(temp){
    temp=temp.toString();
    debugPrint('set num ki  value--->  ' + temp);
    if (temp == '0'){
      setState(() {
        this.i = 0;
      });
    }

    if (temp == '1'){
      setState(() {
        this.i = 1;
      });
    }

    if (temp == '2'){
      setState(() {
        this.i = 2;
      });
    }

    if (temp == '3'){
      setState(() {
        this.i = 3;
      });
    }

    if (temp == '4'){
      setState(() {
        this.i = 4;
      });
    }

    debugPrint('set num  ' + temp);
  }

  updateFromSP() async {
    int i = await getThemeFromSP();

    if (i == 0) {
      setNum(0);
    }
    if (i == 1) {
      setNum(1);
    }
    if (i == 2) {
      setNum(2);
    }
    if (i == 3) {
      setNum(3);
    }
    if (i == 4) {
      setNum(4);
    }

    debugPrint('update from sp ' + i.toString());
  }




}

class MaterialAppWithTheme extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      title: 'Notekeeper',
      home: NoteList(),
    );
  }
}





