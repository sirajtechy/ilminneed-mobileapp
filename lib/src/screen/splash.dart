import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => new SplashScreen()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    if(await ctrl.LoggedIn() == true){
      Navigator.of(context).pushReplacementNamed('/');
    }else{
      Navigator.of(context).pushReplacementNamed('/signIn');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          splashScreen,
          height: 350,
          width: 350,
        ),
      ),
    );
  }
}
