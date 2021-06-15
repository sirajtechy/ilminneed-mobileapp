import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:get/get.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool loggedIn = false;
  bool checked = false;
  _checklogin() async {
    if(await ctrl.LoggedIn() == true){
    setState(() {
      loggedIn = true;
      checked = true;
    });
    }else{
      setState(() {
        loggedIn = false;
        checked = true;
      });
    }
  }

  @override
  void initState() {
    _checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(signIn),
                InkWell(
                  onTap: () async {
                    await ctrl.logout();
                    Get.offAllNamed('/signIn');
                  },
                  child: checked?ButtonWidget(
                    value: loggedIn == true?'Log Out':'Log In',
                  ):Text(''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
