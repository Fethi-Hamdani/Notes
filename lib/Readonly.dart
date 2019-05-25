import 'package:flutter/material.dart';
import 'package:notes/Note.dart';

class Readonly extends StatefulWidget {
  final Note main;
  Readonly(this.main);

  @override
  _ReadonlyState createState() => _ReadonlyState();
}

class _ReadonlyState extends State<Readonly> {
  String note, title, date;

  void initState() {
    super.initState();

    note = widget.main.note;
    title = widget.main.title;
    date = widget.main.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
        child: ListView(
          children: <Widget>[
            Center(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              note,
              style: TextStyle(fontSize: 18, wordSpacing: 5, height: 1.3),
            ),
            SizedBox(
              height: 60,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'This note was create in ' + date,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
