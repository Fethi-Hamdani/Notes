import 'package:flutter/material.dart';
import 'package:notes/Drawer.dart';
import 'package:notes/Sharedpref.dart';
import 'package:notes/NoteView.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool DarkTheme;

  Color Primary, Secondry;
  double thn, tht;

  double sn, st;

  @override
  void initState()
  {
    super.initState();
    getSettings();
  }

  List<FontWeight> s = [FontWeight.w200,FontWeight.w300,FontWeight.w400,FontWeight.w600,FontWeight.w800];

  void getSettings() async {
    DarkTheme = await SharedPreferencesTest().getDarkThemeStatu();

    sn = await SharedPreferencesTest().getNoteSize();
    st = await SharedPreferencesTest().getTitleSize();

    thn = await SharedPreferencesTest().getNoteThikness();
    tht = await SharedPreferencesTest().getTitleThikness();
    /*switch(thn as int)
    {
      case 2 : s = FontWeight.w200;break;
      case 3 : s = FontWeight.w300;break;
      case 4 : s = FontWeight.w400;break;
      case 5 : s = FontWeight.w500;break;
      case 6 : s = FontWeight.w600;break;
      case 7 : s = FontWeight.w700;break;
      case 8 : s = FontWeight.w800;break;
      case 9 : s = FontWeight.w900;break;

    }*/


    setState(() {
      if (DarkTheme) {
        Primary = Colors.blue[900];
        Secondry = Colors.white;
      } else {
        Primary = Colors.blue[300];
        Secondry = Colors.black54;
      }
    });
  }

  Widget Line() {
    return Container(
      height: 0.8,
      color: DarkTheme ? Colors.white70 : Colors.black12,
      margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
    );
  }

  SizedBox Space(double x) {
    return SizedBox(
      height: x,
    );
  }

  Center message(String S) {
    return Center(
        child: Text(
      '$S',
      style:
          TextStyle(color: DarkTheme ? Secondry : Colors.black54, fontSize: 17),
    ));
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => MyNotesPage()));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          iconTheme: IconThemeData(color: Secondry, size: 22),
          /* leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Secondry,
                size: 28,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => MyNotesPage()));
              }),*/
          backgroundColor: Primary,
          title: Text('Settings',
              style: TextStyle(
                color: Secondry,
              )),
        ),
        drawer: DrawerOnly(),
        body: Container(
          color: DarkTheme ? Colors.blue[800] : Colors.grey[300],
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Dark Theme',
                      style: TextStyle(
                          fontSize: 22,
                          color: Secondry,
                          fontWeight: FontWeight.w500),
                    ),
                    Switch(
                        value: DarkTheme,
                        onChanged: (bool t) {
                          setState(() {
                            SharedPreferencesTest().setDarkThemeStatu(t);
                            getSettings();
                          });
                        }),
                  ],
                ),
              ),
              Space(10),
              Line(),
              Space(10),
              Center(child: Text('Title' , style: TextStyle(fontSize: st, fontWeight: s[tht.round()]),)),
              Space(40),
              message('Change note title size'),
              Space(20),
              Center(
                child: Container(
                  width: 280,
                  child: Slider(
                      max: 30,
                      min: 14,
                      value: st,
                      onChanged: (v) {
                        setState(() {
                          st = v;
                          SharedPreferencesTest().setTitleSize(st);
                        });
                      }),
                ),
              ),
              Space(20),
              message('Change note title thikness'),
              Space(20),
              Center(
                child: Container(
                  width: 280,
                  child: Slider(
                      max: 4,
                      min: 0,
                      value: tht,
                      onChanged: (v) {
                        setState(() {
                          tht = v;

                          SharedPreferencesTest().setTitleThikness(tht);
                        });
                      }),
                ),
              ),
              Space(40),
              Line(),
              Space(10),
              Center(child: Text('Body' , style: TextStyle(fontSize: sn , fontWeight: s[thn.round()]),)),
              Space(40),
              message('Change note text size'),
              Space(20),
              Center(
                child: Container(
                  width: 280,
                  child: Slider(
                      max: 30,
                      min: 14,
                      value: sn,
                      onChanged: (v) {
                        setState(() {
                          SharedPreferencesTest().setNoteSize(v);
                          sn = v;
                        });
                      }),
                ),
              ),
              Space(20),
              message('Change note text thikness'),
              Space(20),
              Center(
                child: Container(
                  width: 280,
                  child: Slider(
                      max: 4,
                      min: 0,
                      value: thn,
                      onChanged: (v) {
                        setState(() {
                         thn = v ;
                         SharedPreferencesTest().setNoteThikness(thn);
                        });
                      }),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: 300,
                  child: RaisedButton(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: DarkTheme ? Secondry : Primary),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20, 20))),
                      elevation: 4,
                      color: Primary,
                      child: Center(
                        child: Text(
                          'Reset to default',
                          style: TextStyle(color: Secondry, fontSize: 16),
                        ),
                      ),
                      onPressed: () {
                       /* SharedPreferencesTest()
                            .setDarkThemePrimary(Colors.blue[900].toString());
                        SharedPreferencesTest()
                            .setDarkThemeSecondry(Colors.white.toString());
                        SharedPreferencesTest()
                            .setLightThemePrimary(Colors.blue[300].toString());
                        SharedPreferencesTest()
                            .setLightThemeSecondry(Colors.black54.toString());
*/
                        SharedPreferencesTest().setNoteSize(16);
                        SharedPreferencesTest().setNoteThikness(2);
                        SharedPreferencesTest().setTitleSize(17);
                        SharedPreferencesTest().setTitleThikness(3);
                        getSettings();
                        setState(() {});
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
