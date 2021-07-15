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
                  child: Column (
                    children: [
                      Image(
                        image: AssetImage(success),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Thank You!',
                        style: largeTextStyle()
                            .copyWith(fontSize: 32, color: konDarkBlackColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your Purchase was successful',
                        style: mediumTextStyle().copyWith(fontSize: 15, color: konDarkColorD3),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    topLeft: Radius.circular(0)),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: FlatButton(
                        onPressed: () async {
                          Get.offAllNamed('/', arguments: 2);
                        },
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: konTextInputBorderActiveColor,
                        child: Text(
                          'Start Learning',
                          textAlign: TextAlign.left,
                          style: ctaTextStyle().copyWith(color: konLightColor1, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
