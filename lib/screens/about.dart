import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            buildCardWidget(Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Text('About app'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Center(
                  child: Text('Developed by'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                ),
                SizedBox(height: 15,),
                Center(
                  child: Text('razorcalhn'.toLowerCase(),
                      style: TextStyle(
                        fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1)),
                ),
                SizedBox(height: 35,),
                Center(child: Text('Source code')),
                Center(
                    child:MaterialButton(
                      color: Colors.white70,
                      child: Container(
                        width: 70,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children : <Widget>[Icon(
                          Icons.link
                        ),
                          Text('Github')]),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: (){
                        launch('https://github.com/razorcalhn/notekeeper_app');
                      },
                    ) )


              ],
            )),
            buildCardWidget(Center(
              child: Column(
                children: <Widget>[
                  Text('made with'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5
                  ),),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/flutter.png'),
                        width: 100,height: 50,
                      ),
                      Icon(
                        Icons.add,
                        size: 25,
                      ),
                      Image(
                        image: AssetImage('assets/dart.png'),
                        width: 100,height: 50,
                      ),
                    ],
                  ),

                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
}




////add a made with flutter logo!




Widget buildCardWidget(Widget child) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              offset: Offset(0,20),
              color: Colors.black.withAlpha(30),
              blurRadius: 10)
        ]),
    margin: EdgeInsets.all(24),
    padding: EdgeInsets.fromLTRB(16,0,16,16),
    child: child,
  );

}
