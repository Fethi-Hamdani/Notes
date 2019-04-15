import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:notes/Note.dart';
import 'package:notes/NoteView.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Drawer.dart';
import 'Drawer.dart';
import 'main.dart';

class EditNote extends StatefulWidget {
  final int turn;
  Note note;
  EditNote(this.turn, [this.note]);

  @override
  _EditNoteState createState() => _EditNoteState();
}

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd' + ' At ' + 'H:m');
Color notecolor = Colors.white;
 List clrbtns = [
    Color.fromARGB(255, 254, 212, 63 ),
    Color.fromARGB(255, 71 , 254, 102),
    Color.fromARGB(255, 87 , 148, 254),
    Color.fromARGB(255, 253, 136, 47 ),
    Color.fromARGB(255, 254, 71 , 242),
    Color.fromARGB(255, 71 , 199, 254),
    Color.fromARGB(255, 16 , 254,  24),
    Color.fromARGB(255, 246, 254, 11 ),
    Color.fromARGB(255, 254, 11 , 222),
    Color.fromARGB(255, 11 , 254, 254),
    Color.fromARGB(255, 254, 112, 112),
  ];


class _EditNoteState extends State<EditNote> {
  double font = 15;
  String note;

  String btntext = 'Fethi';
  String headertxt;
  bool pin = false;
  bool lnchbtn = false;
  int noteindex;

  
  bool stab = false;
  DatabaseHelper databaseHelper = DatabaseHelper();


  void handlestart() {
    setState(() {

      now = new DateTime.now();
      if (widget.turn == 2) {
        headertxt = "Edit Note";
        btntext = 'Save Changes';
         pin = widget.note.pin ? true :false;
        _controller.text = widget.note.note;
         title.text = widget.note.title;
        _controller.selection = new TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));

        title.selection = new TextSelection.fromPosition(
            new TextPosition(offset: title.text.length));
        lnchbtn = true;
      } else {
        headertxt = "Add Note";
        btntext = 'Add Note';

      }
      if (stab) {
        for (int i = 0; i < clrbtns.length; i++) {
          if (clrbtns[i].on) {
            clrbtns[i].c = clrbtns[i].click;
            clrbtns[i].click = Colors.white;
            clrbtns[i].on = false;
          }
        }
        stab = false;
      }
    });
  }

  Container deletebtn() {
    if (widget.turn == 2)
      return new Container(
          child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  databaseHelper.deleteNote(widget.note.id);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MyNotesPage()));
                });
              }));
    else
      return Container();
  }

  TextEditingController _controller = new TextEditingController();
  TextEditingController title = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    handlestart();
    return new WillPopScope(
      onWillPop: (){
        setState(() {
          if (widget.turn != 2) {
            if (_controller.text.length > 0) {
              databaseHelper.insertNote(new Note(title.text, _controller.text,
                  formatter.format(now), notecolor.toString() , pin ));
            }
          } else {
            widget.note.title = title.text;
            widget.note.pin = pin ;
            widget.note.note = _controller.text;
            widget.note.description = notecolor.toString();
            databaseHelper.updateNote(widget.note);
          }

          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => MyNotesPage()));
        });

      },
      child : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('$headertxt',
            style: TextStyle(
              color: Colors.white,
            )),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
        IconButton(
              icon: Icon(
                pin ? Icons.star : Icons.star_border,
                color: Colors.yellowAccent[200],
                size: 28,
              ),
              onPressed: () {
                setState(() {

                  widget.turn==2 ? widget.note.pin = !widget.note.pin : pin = !pin;
              });}),
          deletebtn(),
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.lightBlue[400],
              size: 25,
            ),
            onPressed: () {
              setState(() {
                if (widget.turn != 2) {
                  if (_controller.text.length > 0) {
                    databaseHelper.insertNote(
                        new Note(title.text,_controller.text,
                        formatter.format(now), notecolor.toString(), pin));
                  }
                } else {
                  widget.note.title = title.text;
                  widget.note.note = _controller.text;
                  widget.note.pin = pin ;
                  widget.note.description = notecolor.toString();
                  databaseHelper.updateNote(widget.note);
                }

                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => MyNotesPage()));
              });
            },
          ),
        ],
      ),
     drawer: new DrawerOnly(),
      body: new Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[600],Colors.blue[500], Colors.blue[900]],begin:Alignment.topLeft , end:Alignment.bottomRight)),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:clrbtns.length,
                  itemBuilder: (BuildContext context, int index) {

                    bool on = false;
                    Color c1 = Colors.grey[200], c2 = clrbtns[index];
                    return Container(

                      decoration: BoxDecoration(color: c1,border: Border.all(color: Colors.blue[900] , width: 2), borderRadius: BorderRadius.all(Radius.circular(30) )),
                      height: 10,
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(top: 5,left: 2),
                      child: IconButton(
                          padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
                          icon: Icon(Icons.blur_on),
                          color: c2,
                          iconSize: 45,
                          onPressed: () {
                            setState(() {
                              if (!on) {
                                c1 = c2;
                                notecolor = c1;
                                c2 = Colors.white;
                                on = !on ;
                              } else {
                                c2 = c1;
                                c1 = Colors.white;
                                notecolor = c1;
                                on = !on;
                              }
                            });
                          }),
                      /* blur_circular
          blur_on
          camera*/
                    );;
                  }),
            ),
            Opacity(
              opacity: 0.8,
              child: new Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.blue[900] , width: 2), gradient:LinearGradient(colors: [notecolor, Colors.white70 ,notecolor] ,begin: Alignment.topLeft , end : Alignment.bottomRight) , borderRadius: BorderRadius.all(Radius.circular(15))),
               // color: notecolor,
                margin: EdgeInsets.only(right: 15 ,left: 15, top: 10 ,bottom: 5),

                height :490,
                child: Column(
                  children: <Widget>[
                    Center(child: Container(  padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(border: Border(left: BorderSide(width: 2,color: Colors.blue[900]))),margin: EdgeInsets.only( top: 10),width: 220 , child: TextField( decoration: InputDecoration.collapsed(hintText: ' Title here'), controller: title, textAlign:TextAlign.justify ,maxLines: 1 , style: new TextStyle(fontSize: 20 , fontWeight: FontWeight.w700 ), )),),
                    Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(width: 2 ,color: Colors.blue[900]))),
                      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
                      padding: EdgeInsets.only(bottom: 2, top: 8, right: 5, left: 5),
                      child: TextField(
                        decoration: InputDecoration.collapsed(hintText: ' Body here'),
                        maxLines: null,
                        controller: _controller,
                        style: new TextStyle(wordSpacing: 2,fontSize: 18 , fontWeight: FontWeight.w500 ),
                        autocorrect: false,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }



}





