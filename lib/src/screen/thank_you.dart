import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:get/get.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                ),
              ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child:Text(
                  'Thank You!',
                  style: largeTextStyle().copyWith(fontSize: 32, color: konDarkBlackColor),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Get.offAllNamed('/');
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ButtonWidget(
                  value: 'Start Learning',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}