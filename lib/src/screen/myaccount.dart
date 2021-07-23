import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:get/get.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  bool loggedIn = false;
  bool checked = false;
  String name = 'Hello guest';
  String email = '';

  _checklogin() async {
    if(await ctrl.LoggedIn() == true){
      var n = await ctrl.getusername();
      var e = await ctrl.getemail();
      setState(() {
        loggedIn = true;
        checked = true;
        name = n;
        email = e;
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
      backgroundColor: konLightColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor1,
        title: Text(
          'Account',
          style:
          buttonTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ShoppingCartButtonWidget(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 5,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: konTextInputBorderActiveColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                    name.toString(),
                    style: buttonTextStyle()
                        .copyWith(fontSize: 18, color: konDarkColorB1),
                  )),
              SizedBox(height: 10),
              Center(
                  child: Text(
                    email.toString(),
                    style: smallTextStyle()
                        .copyWith(fontSize: 18, color: konDarkColorB2),
                  )),
              SizedBox(height: 50),
              Text(
                'Settings',
                style: smallTextStyle()
                    .copyWith(fontSize: 12, color: konLightColor),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email notification preferences',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning reminders',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Support',
                style: smallTextStyle()
                    .copyWith(fontSize: 12, color: konLightColor),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Ilmineed',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently asked questions',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report a bug',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Legal',
                style: smallTextStyle()
                    .copyWith(fontSize: 12, color: konLightColor),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy policy',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms and conditions',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              checked?Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        await ctrl.logout();
                        Get.offNamed('/signIn');
                      },
                      child: Text(
                        loggedIn == true?'Sign Out':'Sign In',
                        style: smallTextStyle()
                            .copyWith(fontSize: 16, color: konPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
