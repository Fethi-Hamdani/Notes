import 'package:flutter/material.dart';

class MySketcherPage extends StatefulWidget {
  MySketcherPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  MySketcherState createState() => MySketcherState();
}


class MySketcherState extends State<MySketcherPage> {
  List<Offset> points = <Offset>[];
  double brushSize = 20.0;
  bool show = false;

  @override
  Widget build(BuildContext context) {

    final Container sketchArea = Container(
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.blue,
      child: CustomPaint(
        painter: Sketcher(points , brushSize),
      ),
    );

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:
      Stack(
        children: <Widget>[
          GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox box = context.findRenderObject();
                  Offset point = box.globalToLocal(details.globalPosition);
                  point = point.translate(0.0, -(AppBar().preferredSize.height));

                  points = List.from(points)..add(point);
                });
              },
              onPanEnd: (DragEndDetails details) {
                points.add(null);
              },
              child: sketchArea,
              onDoubleTap:() {
                setState((){
                  show = true ;
                });
              }
          ),
          show ? Center(child  : Container(
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(10) ) ,
                gradient: LinearGradient(colors: [Colors.grey[400],Colors.blue[100],Colors.grey[400],  ], begin: Alignment.topRight,end: Alignment.bottomLeft,)),
            width: 300,
            height: 400,

            child : FlatButton(
              child: new Column(
                children: <Widget>[

                  Text("Brush size" , style: TextStyle(fontSize: 14 ),),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 2.0,
                    max: 30.0,
                    onChanged: (newRating) {
                      setState(() {
                        brushSize  = newRating;
                      });
                    },
                    value: brushSize,
                  ),
                  FlatButton(
                    child: Text('touch me'),
                    onPressed: (){setState(() {
                      brushSize =  20;
                    });},
                  ),

                ],),
              onPressed: () {
                setState((){show = false;});
              },
            ),)) : Container(),

        ],),

      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() => points.clear());
        },
      ),


    );
  }
}
class Sketcher extends CustomPainter {
  final List<Offset> points;
  final double BrushSize;
  Sketcher(this.points,this.BrushSize);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = BrushSize;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }
}