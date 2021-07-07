import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  AnimationController _controller;
  CurvedAnimation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
     animation=CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.addListener(() {
      setState(() {

      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDice = Random().nextInt(6) + 1;
          rightDice = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ROll DICE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage('assets/images/dice-png-$leftDice.png'),
                        )),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage('assets/images/dice-png-$rightDice.png'),
                        )),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: roll,
              child: Text("ROLL"),
            )
          ],
        ),
      ),
    );
  }
}
