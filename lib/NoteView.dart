import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:notes/Readonly.dart';
import 'package:flutter/material.dart';
import 'package:notes/DataBaseHelper.dart';
import 'package:notes/Note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqlite_api.dart';
import 'Drawer.dart';
import 'package:notes/Sharedpref.dart';
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

  bool DarkTheme ;
  Color Primary, Secondry;

  int listitems = 0;
  int reduction;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  List<Note> pinned = List(), normal = List();

  Widget delay(int index) {
    return index == 0 && show
        ? wi1()
        : index < pinned.length + 1 && show
            ? new CustomCard(pinned[(pinned.length - 1) - (index - 1)])
            : index == pinned.length + 1 && show
                ? wi2()
                : new CustomCard(normal[
                    (normal.length + reduction) - (index - pinned.length)]);
  }

  void updateListView() {
    Note note;


    final Future<Database> dbFuture = databaseHelper.initializeDatabase();


    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          if (noteList.length<1){
            show = true;
            reduction = 1;
            listitems = 3;
            pinned.add(new Note('Welcome!!','\n\n   double click me to learn more about the app \n\n\n Enjoy! managing your notes, ideas, poems, activities on a more entertaining way, add another note to auto delete this one'
                'read more about our app in the help center ','right now',Colors.blue[300].toString(),true));

          }
          else{
          for (int i = 0; i < noteList.length; i++) {
          note = noteList[i];
          if (note.pin) {
          pinned.add(note);
          show = true;
          } else
          normal.add(note);
          }
          if (show) {
          listitems = pinned.length + normal.length + 2;
          reduction = 1;
          } else {
          reduction = -1;
          listitems = pinned.length + normal.length;
          }
          }
          });
      });
    }) ;



  }



  @override
  void initState() {
    _start();
    super.initState();
  }


  void _start() async {

    DarkTheme = await SharedPreferencesTest().getDarkThemeStatu();

    if (DarkTheme) {
      Primary = Colors.blue[900];

      Secondry = Colors.white;
    } else {
      Primary = Colors.blue[300];
      Secondry = Colors.black54;

      setState(() {  precacheImage(AssetImage("assets/images/vors.jpg"), context);
      });
    }
  }

  Widget wi1() {
    return new Center(
        child: Text(
      'Pinned',
      style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Secondry),
    ));
  }

  Widget wi2() {
    return new Center(
        child: Container(
      width: 300,
      height: 0.8,
      color: Secondry,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return DarkTheme== null ? Scaffold(body : Center(child : Container(height: 3, padding : EdgeInsets.only(left: 30 , right: 30),color: Colors.white,child : LinearProgressIndicator()))) :new WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Exit App"),
              content: new Text(
                "Are you sure you want to exit ?",
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "Yes",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(

          /*borderRadius: new BorderRadius.vertical(
          bottom: new Radius.elliptical(
              MediaQuery.of(context).size.width, 100.0)),
          ),*/

          elevation: 5,
          backgroundColor: Primary,
          title: Text('My Notes',
              style: TextStyle(
                color: Secondry,
              )),
          iconTheme: new IconThemeData(color: Secondry),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                con,
                color: Secondry,
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
        body:DarkTheme == null ? Center(child: CircularProgressIndicator(),): listitems<1 ? Center(child: CircularProgressIndicator(),):Container(
          //  color: Colors.redAccent,
          padding: EdgeInsets.only(
              top: pinned.length > 0 ? 0 : 15, left: 3, right: 3),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: DarkTheme
                      ? ([Colors.blue[700], Colors.blue[600], Colors.blue[800]])
                      : [Colors.grey[300], Colors.grey[300]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: new StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: listitems,
            itemBuilder: (BuildContext context, int index) => delay(index),
            staggeredTileBuilder: (int i) => i == 0 && show
                ? new StaggeredTile.count(4, 0.6)
                : i == pinned.length + 1 && show
                    ? new StaggeredTile.count(4, 0.6)
                    : new StaggeredTile.fit(2 * notesview),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              color: DarkTheme ? Secondry : null,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.all(2),
          child: FloatingActionButton(
            backgroundColor: Primary, //Color.fromARGB(255, 71, 199, 254),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => EditNote(1)));
            },
            child: Icon(
              Icons.queue,
              color: Secondry,
            ),
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

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  double fontnote = 16;
  double fonttitle = 17;

  FontWeight thnote = FontWeight.w400 , thtitle = FontWeight.w600;

  Color mycolor;

  bool forward = true;

  double angel = 1 , angel2 = 1;


  @override
  void initState() {
    super.initState();
    start();

  }

  DatabaseHelper databaseHelper = DatabaseHelper();

  void start()async{

    List<FontWeight> s = [FontWeight.w200,FontWeight.w300,FontWeight.w400,FontWeight.w600,FontWeight.w800];

    double a ,b ;
   fontnote = await SharedPreferencesTest().getNoteSize();
   fonttitle = await SharedPreferencesTest().getTitleSize();

   a = await SharedPreferencesTest().getNoteThikness();
   b = await SharedPreferencesTest().getTitleThikness();

   thnote = s[a.round()];
   thtitle = s[b.round()];
   setState(() {
   });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    mycolor = new Color(int.parse(
        widget.note.description.split('(0x')[1].split(')')[0],
        radix: 16));


    return Stack(
      children: <Widget>[
        Container(
          height: widget.note.title.length > 0 ? 140 : 106,
          padding: EdgeInsets.only(bottom: 0, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {

                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      EditNote(2, widget.note)));
                        });
                      },
                      icon: Icon(
                        Icons.mode_edit,
                        color: Colors.green[600],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.note.pin = !widget.note.pin;
                        databaseHelper.updateNote(widget.note);

                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MyNotesPage()));
                      });
                    },
                    icon: Icon(
                      widget.note.pin ? Icons.star : Icons.star_border,
                      color: Colors.yellowAccent,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {

                        databaseHelper.deleteNote(widget.note.id);

                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MyNotesPage()));
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Readonly(widget.note)));
                      });angel = 1;
                      angel2 = 1;
                    },
                    icon: Icon(
                      Icons.receipt,
                      color: Colors.lightBlue,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: ()
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => Readonly(widget.note)));
          },

          onLongPress: ()
          {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => EditNote(2, widget.note)));
          },

          onTap: ()
          {

            setState(() {

              if (angel==0.55) {
                angel = 1;
                angel2 = 1;
              }
                else {
                  angel2 = 0.7;
                angel = 0.55;
              }
            });

          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 800),
            transform: Matrix4.identity()..scale(angel2 ,angel),
            curve: Curves.easeIn,
            child: Container(
              decoration: ShapeDecoration(
                color: mycolor,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: mycolor),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                    )),
                shadows: [BoxShadow(blurRadius: 4.0, spreadRadius: 0)],
              ),
              margin: EdgeInsets.all(5),
             // transform: Matrix4.identity()..scale(hideShowAnimation.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      widget.note.title.length > 0
                          ? new Center(
                              child: new Text(
                                widget.note.title,
                                style: new TextStyle(
                                    fontSize: fonttitle, fontWeight: thtitle),
                              ),
                            )
                          : new Container(),
                      widget.note.title.length > 0
                          ? new Container(
                              height: 1.3,
                              color: Colors.black26,
                              margin: EdgeInsets.only(
                                  right: 15, left: 10, top: 2, bottom: 2),
                            )
                          : Container(),
                      new Container(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        constraints: new BoxConstraints(
                          minHeight: 60.0,
                          maxHeight: 95.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new Text("${widget.note.note}",
                                style: new TextStyle(
                                  fontSize: fontnote,fontWeight: thnote,
                                )),
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
                          child: Text(widget.note.date,
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
          ),
        ),
      ],
    );
  }

/*String _getPositions() {
    final RenderBox renderBoxRed = key.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    return positionRed;
  }*/

}
