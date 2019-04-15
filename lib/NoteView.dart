
import 'package:flutter/material.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:notes/Note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqlite_api.dart';
import 'Drawer.dart';
import 'Editnote.dart';

class MyNotesPage extends StatefulWidget {
  MyNotesPage();

  @override
  _MyNotesPageState createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  int notesview = 1;
  IconData con = Icons.view_stream;
  _MyNotesPageState();

  bool show = false;
  int listitems = 0;
  int reduction;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList ;
  List<Note> pinned = List() ,  normal = List();
  void updateListView() {

     Note note;
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          for(int i = 0 ; i<noteList.length ; i++)
          {
            note = noteList[i];
            if(note.pin)
              {pinned.add(note); show = true;
              }
            else
              normal.insert(0, note);
          }
          if(show)
            {
              listitems = pinned.length + normal.length + 2;
              reduction = 1;
            }
            else
              {
                reduction = -1;
                listitems = pinned.length + normal.length;
              }

        });
      });
    });

  }

  void _start() {

    setState(() {
      precacheImage(
          AssetImage(
              "assets/images/vors.jpg"
              ) ,context
          );
    });
  }

  Widget wi1(){

    return new Center( child : Text('Pinned' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22 , color: Colors.white ),));
  }
  Widget wi2(){

    return new Center(child:Container(width: 300,height: 0.8,color: Colors.black26,));
  }

  @override
  Widget build(BuildContext context) {
    _start();
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();

    }
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.blue[900] ,
        title: Text('My Notes',
            style: TextStyle(
              color: Colors.white,
            )),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              con,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {

                if (notesview == 2) {
                  notesview = 1;
                  con = Icons.view_stream;
                } else {
                  notesview = 2;
                  con = Icons.view_quilt;
                }
              });
            },
          ),
        ],
      ),
      drawer: new DrawerOnly(),
      body:

      Container(
                //  color: Colors.redAccent,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[700],Colors.blue[600], Colors.blue[900]],begin:Alignment.topLeft , end:Alignment.bottomRight)),
                  child: new StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: listitems,
                      itemBuilder:
                          (BuildContext context, int index) =>
                      index == 0 && show ? wi1() : index < pinned.length+1 && show ? new CustomCard(pinned[(pinned.length-1) - (index-1)]) : index == pinned.length+1 && show? wi2() : new CustomCard(normal[(normal.length+reduction) - (index-pinned.length)] ),

                      staggeredTileBuilder: (int i) =>

                     i==0&&show ? new StaggeredTile.count(4, 0.6) : i == pinned.length+1&&show ? new StaggeredTile.count(4, 0.6) : new StaggeredTile.fit(2 * notesview),

                  ),
                ),



      floatingActionButton: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.all(2),
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],//Color.fromARGB(255, 71, 199, 254),
          onPressed: () {
            Navigator.pushReplacement(context,
                                          new MaterialPageRoute(builder: (context) => EditNote(1)));
          },
          child: Icon(
            Icons.queue,
            color: Colors.white,
            ),
          ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      );
  }

}

class CustomCard extends StatefulWidget {
  CustomCard(this.note);
  Note note;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  double font = 16;

  @override
  Widget build(BuildContext context) {
    return new Card(

      elevation: 2,
      margin: EdgeInsets.all(5),
      child: FlatButton(

        splashColor: Colors.blueAccent,
        color: new Color(int.parse(widget.note.description.split('(0x')[1].split(')')[0] ,radix: 16)),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      EditNote(2,widget.note)));
        },

        padding: EdgeInsets.only(left: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  widget.note.title.length >0 ? new Center(child: new Text(widget.note.title, style: new TextStyle(fontSize: 17 , fontWeight: FontWeight.w600),) ,) : new Container(),
                new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 100.0,
                    maxHeight: 200.0,

                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("${widget.note.note}",
                          style: new TextStyle(
                            fontSize: 16,)),
                    ],
                  ),
                ),

              ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5, right: 5),
                  child: Align(
                    alignment: Alignment(1, 0),
                    child: Text( widget.note.date ,
                                    style: new TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      )),
                    ),
                  ),
              ],
              ),
          ],
          ),
        ),
      );

  }



}
