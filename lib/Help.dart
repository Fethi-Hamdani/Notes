import 'package:flutter/material.dart';
import 'package:notes/NoteView.dart';
import 'package:notes/Sharedpref.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  bool DarkTheme = MyNotesPage().createState().DarkTheme;

  Color Primary , Secondry;

  void start()async{


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

  void initState(){
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
      setState(() {

        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => MyNotesPage()));
      });
    },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Secondry,
                size: 28,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (ctxt) => MyNotesPage()));
              }),
          backgroundColor:Primary,
          title: Text('Help Center',
              style: TextStyle(
                color: Colors.white,
              )),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          children: <Widget>[
            Text('About app :',
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Rock Salt")),
            SizedBox(
              height: 20,
            ),
            Text(
                'the purpose of making this app is to give the user a diffrent experience on manging thoughts and notes,'
                'it is pretty handy and joyfull due to the use of some happy colors instead of black and white plus to the dark theme '
                'that makes it less bilinding to the user and also protect their eye seight.'
                '\nmoving on to the components of the app :',
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 15,
            ),
            Text('Note structure :',
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Rock Salt")),
            SizedBox(
              height: 15,
            ),
            Text('each indivudale note has 4 main parts : ',
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("Title (not obligatory) :",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "one line text describing the note's content brifely, the choice is yours to add it or not, on the settings page you can change the Title size and thickness. ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("Body  (obligatory):",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "multiple lines text containing your note, ideas, poems, thoughts, kharbchat ... etc, you can also customize the font size and thickness (font weight) of the text from the settings page ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("Date  (automatic):",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "auto generated date and time when the note is created to help you orgnize your notes well",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("Color (not obligatory):",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "you can pick a color from the list of colors above the note context and it is by default white if you didn't want to chose and you can change the default color from the settings page. ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Note fanctionalities:',
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Rock Salt")),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("SingleTap :",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                " tap (click) on a note to bring in shourtcut fanctionalities for quick access like (delete, pin/unpin, read) ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("DoubleTap :",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                " double tap (click) on a note to enter read mode where you can read your notes and stuff more clearer and bigger and without the extra options that you don't need of course while reading ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  radius: 5,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text("LongPress :",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                " longPress (Hold) on a note to edit all feilds of the note such as (the title, notebody, pin status, background color..) but you can't edit the date of creation because it point to the time the note was created and it doesn't make sense if you are able to change it ",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 20,
            ),
            Text('Contact:',
                style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Rock Salt")),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                " My Gmail :    fethinvrfail@gmail.com",
                style: new TextStyle(fontSize: 16)),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
