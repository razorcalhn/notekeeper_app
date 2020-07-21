import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
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
          SizedBox(height: 70,),
          Image(
            image: AssetImage('assets/batman.png'),width: 60,height: 60,
          ),
          Center(
            child: Text('''Here's a random batman logo coz why not''',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54
            ),),
          )

        ],
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
              offset: Offset(5, 15),
              color: Colors.black.withAlpha(20),
              blurRadius: 16)
        ]),
    margin: EdgeInsets.all(24),
    padding: EdgeInsets.all(16),
    child: child,
  );

}
