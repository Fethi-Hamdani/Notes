import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notes/Editnote.dart';
import 'package:notes/Drawer.dart';
import 'package:notes/NoteView.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(

        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text('Home' ),
        ),
      drawer: new DrawerOnly(),
      body:

            Container(
            /*  decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue[500], Colors.blue[100],Colors.blue[400],],
                    begin: Alignment.topRight,end: Alignment.bottomLeft,)),*/
              child: new Row(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                            new GestureDetector(
                              onTap:(){ Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (ctxt) => EditNote(1)));},
                              child :getpage(Icons.note_add, Colors.lightBlue, Colors.lime),
                                ),
                            new GestureDetector(

                              onTap:(){ Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (ctxt) => MyNotesPage()));},
                                child: getpage(Icons.home, Colors.lightBlue, Colors.blueGrey)
                            ),

                        ]

                        ),

                    new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new GestureDetector(
                              onTap: iconButtonPressed,
                              child : getpage(Icons.add_box, Colors.lightBlue, Colors.lightGreenAccent)),


                          new GestureDetector(
                              onTap: iconButtonPressed,
                              child :getpage(Icons.add_a_photo, Colors.lightBlue, Colors.limeAccent)),
                        ]

                        )
                  ]

                  ),
            )


      );
  }
  void iconButtonPressed(){ setState(() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Page under Construction"),
          content: new Text("this page is still under construction"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("go back "),
              onPressed: () {
                Navigator.of(context).pop();
              },
              ),
          ],
          );
      },
      );
  });}

  Widget getpage(IconData c , Color a , Color b ){

      return new Container(

        decoration: BoxDecoration(color: a,borderRadius: BorderRadius.all(Radius.circular(10) ) ,
                                        gradient: LinearGradient(colors: [Colors.redAccent[100],  Colors.red,  Colors.redAccent[100],],
                                        end: Alignment.topRight,begin: Alignment.bottomLeft,)),
        padding: EdgeInsets.only(top: 0 , left: 0 ,right: 0 , bottom: 0),
        margin: EdgeInsets.all(10),
        height: 120,
        width: 120,

        child: new Icon(
          c,
          size: 50,
          color: b,
          ),


    );

  }

}