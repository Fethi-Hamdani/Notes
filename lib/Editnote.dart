import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:notes/Note.dart';
import 'package:notes/NoteView.dart';
import 'package:notes/Sharedpref.dart';
import 'Drawer.dart';

class EditNote extends StatefulWidget {
  final int turn;
  Note note;
  EditNote(this.turn, [this.note]);

  @override
  _EditNoteState createState() => _EditNoteState();
}

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd' + ' At ' + 'H:m');
Color notecolor;
List clrbtns = [
  Colors.blue[300],
  Colors.yellow[300],
  Colors.red[300],
  Colors.green[400],
  Colors.blueGrey[200],
  Colors.orange[300],
  Colors.deepPurple[200],
];

class _EditNoteState extends State<EditNote> {
  double font = 15;
  String note;

  String headertxt;
  bool pin;
  bool lnchbtn = false;
  int noteindex;

  bool DarkTheme ;
  Color Primary =Colors.white;
  Color Secondry =Colors.white;
  Color Default=Colors.white;

  bool stab = false;
  DatabaseHelper databaseHelper = DatabaseHelper();

  void gettheme() async {

    DarkTheme = await SharedPreferencesTest().getDarkThemeStatu() ?? false;


    String prim, sec;

    if (DarkTheme) {

      Primary = Colors.blue[900];

      Secondry = Colors.white;

    } else {

      Primary =     Colors.blue[300];
      Secondry =  Colors.black54;16 ;
    }
    setState(() {});
  }

  void initState() {
    super.initState();
    gettheme();

    setState(() {
      now = new DateTime.now();
      if (widget.turn == 2) {
        headertxt = "Edit Note";
        pin = widget.note.pin ? true : false;
        _controller.text = widget.note.note;
        notecolor = new Color(int.parse(
            widget.note.description.split('(0x')[1].split(')')[0],
            radix: 16));
        title.text = widget.note.title;

        _controller.selection = new TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));

        title.selection = new TextSelection.fromPosition(
            new TextPosition(offset: title.text.length));
        lnchbtn = true;
      } else {
        notecolor = Default;
        pin = false;
        headertxt = "Add Note";
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
    return new WillPopScope(
      onWillPop: () {
        setState(() {
          if (widget.turn != 2) {
            if (_controller.text.length > 0) {
              databaseHelper.insertNote(new Note(title.text, _controller.text,
                  formatter.format(now), notecolor.toString(), pin));
            }
          } else {
            widget.note.title = title.text;
            widget.note.pin = pin;
            widget.note.note = _controller.text;
            widget.note.description = notecolor.toString();
            databaseHelper.updateNote(widget.note);
          }

          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => MyNotesPage()));
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Primary,
          title: Text('$headertxt',
              style: TextStyle(
                color: Secondry,
              )),
          iconTheme: new IconThemeData(color: Secondry),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  pin ? Icons.star : Icons.star_border,
                  color: Colors.yellowAccent[200],
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    pin = !pin;
                  });
                }),
            deletebtn(),
            IconButton(
              icon: Icon(
                Icons.save,
                color: DarkTheme ? Colors.blue[400] : Colors.lightBlue[900],
                size: 25,
              ),
              onPressed: () {
                setState(() {
                  if (widget.turn != 2) {
                    if (_controller.text.length > 0) {
                      databaseHelper.insertNote(new Note(
                          title.text,
                          _controller.text,
                          formatter.format(now),
                          notecolor.toString(),
                          pin));
                    }
                  } else {
                    widget.note.title = title.text;
                    widget.note.note = _controller.text;
                    widget.note.pin = pin;
                    widget.note.description = notecolor.toString();
                    databaseHelper.updateNote(widget.note);
                  }

                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MyNotesPage()));
                });
              },
            ),
          ],
        ),
        drawer: new DrawerOnly(),
        body: new Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: DarkTheme
                      ? [Colors.blue[600], Colors.blue[500], Colors.blue[900]]
                      : [Colors.grey[300], Colors.blue[300], Colors.grey[300]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new SizedBox(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: clrbtns.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool on = false;
                          Color c1 = Colors.grey[200], c2 = clrbtns[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: c1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 10,
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: IconButton(
                                padding: EdgeInsets.only(
                                    top: 0, left: 5, right: 5, bottom: 0),
                                icon: Icon(Icons.blur_on),
                                color: c2,
                                iconSize: 45,
                                onPressed: () {
                                  setState(() {
                                    if (!on) {
                                      c1 = c2;
                                      notecolor = c1;
                                      c2 = Colors.white;
                                      on = !on;
                                    } else {
                                      c2 = c1;
                                      c1 = Colors.white;

                                      on = !on;
                                    }
                                  });
                                }),
                            /* blur_circular
                  blur_on
                  camera*/
                          );
                          ;
                        }),
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: ConstrainedBox(
                      constraints: new BoxConstraints(minHeight: 500),
                      child: new Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [notecolor, Colors.white70, notecolor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        // color: notecolor,
                        margin: EdgeInsets.only(
                            right: 15, left: 15, top: 10, bottom: 5),

                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 2, color: Primary ?? Colors.white))),
                                  margin: EdgeInsets.only(top: 10),
                                  width: 220,
                                  child: TextField(
                                    decoration: InputDecoration.collapsed(
                                        hintText: ' Title here'),
                                    controller: title,
                                    textAlign: TextAlign.justify,
                                    maxLines: 1,
                                    style: new TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                            GestureDetector(
                              child: Container(
                                height: 435,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 2, color: Primary ))),
                                margin: EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 5),
                                padding: EdgeInsets.only(
                                    bottom: 2, top: 8, right: 5, left: 5),
                                child: TextField(
                                  scrollPadding: EdgeInsets.all(1),
                                  decoration: InputDecoration.collapsed(
                                      hintText: ' Body here'),
                                  maxLines: null,
                                  controller: _controller,
                                  style: new TextStyle(
                                      wordSpacing: 2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  autocorrect: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
