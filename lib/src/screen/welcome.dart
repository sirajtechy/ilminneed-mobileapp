import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              startScreen,
              height: 350,
              width: 350,
            ),
            Text(
              'Start learning Anything anywhere',
              style: largeTextStyle()
                  .copyWith(fontSize: 32, color: konDarkBlackColor),
            ),
            InkWell(
              onTap: () async {
                if (await ctrl.LoggedIn() == true) {
                  Get.offAllNamed('/',
                      arguments: {'currentTab': 0, 'data': ''});
                } else {
                  Get.offAllNamed('/signUp');
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ButtonWidget(
                  value: 'Start Learning',
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Get.offAllNamed('/', arguments: {'currentTab': 0, 'data': ''});
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Text(
                    'Continue as guest',
                    style: largeTextStyle()
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
