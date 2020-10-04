import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Clock',
      home: HomeScreen(),
    )
  );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  Animation animation;
  AnimationController animationController;

  _currentTime(){
    var hour = DateTime.now().hour;
    var min = DateTime.now().minute;

    var res = "";
    var cnt = 2, cnt1 = 2;

    if(hour <= 9) cnt = 1;
    if(min <= 9) cnt1 = 1;

    if(cnt == 1) res += "0${DateTime.now().hour}";
    else res += "${DateTime.now().hour}";

    if(cnt1 == 1) res += " : 0${DateTime.now().minute}";
    else res += " : ${DateTime.now().minute}";

    return res;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animationController.addListener(() {

      if(animationController.isCompleted) {
        animationController.reverse();
      }
      else if(animationController.isDismissed) {
        animationController.forward();
      }

      setState(() {
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 20.0,
                color: Colors.brown.shade900,
                child: Container(
                  width: 320,
                  height: 320,
                  child: Center(
                    child: Text(
                      _currentTime(),
                      style: TextStyle(
                        fontSize: 70.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    'images/pendulum.png',
                    width: 100,
                    height: 275,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
