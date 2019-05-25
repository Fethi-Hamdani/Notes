import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  bool forward = false;
  Animation hideShowAnimation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    hideShowAnimation = Tween(begin: 0.0, end: 0.85).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
      body: Center(child: Container(height: 200, width: 150, color: Colors.purple[200],)),
    );
  }
}
