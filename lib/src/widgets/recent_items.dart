import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class RecentItems extends StatelessWidget {
  final List value;
  final String label;
  final String type;

  const RecentItems({Key key, this.value, this.label,this.type = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.type == 'category'?RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  recognizer:
                  new TapGestureRecognizer()
                    ..onTap = () =>
                        Get.offNamed('/', arguments: 1),
                  text: "Categories ",
                  style: largeTextStyle().copyWith(fontSize: 16, color: konPrimaryColor2)),
              TextSpan(
                  text: "you may like",
                  style: largeTextStyle().copyWith(fontSize: 16, color: konDarkColorB2)),
            ]),
          ):Text(
            label,
            style:
                largeTextStyle().copyWith(fontSize: 16, color: konDarkColorB2),
          ),
          SizedBox(height: 10),
          Wrap(
            runSpacing: 1.0,
            spacing: 5.0,
            children: value
                .map(
                  (e) => InkWell(
                    onTap: (){
                      Get.toNamed('/categoryresult',arguments: { 'id': e.id,'name':e.name.toString() });
                    },
                    child: Chip(
                      backgroundColor: konTextInputBorderActiveColor,
                      label: Text(e.name.toString(), style: smallTextStyle().copyWith(color: konLightColor1),),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
