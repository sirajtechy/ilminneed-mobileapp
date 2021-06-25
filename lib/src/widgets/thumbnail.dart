import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ThumbNailWidget extends StatelessWidget {
  final bool continueLearing;
  final Course course;

  const ThumbNailWidget({Key key, this.continueLearing, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: !continueLearing
                    ? BoxDecoration(
                        color: konImageBGColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: this.course.thumbnail!='null'?NetworkImage(this.course.thumbnail.toString()):Text(''),
                  ),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: orangeGradient,
                        ),
                      ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: konDarkColorB2),
                  child: Text(
                    '12.15',
                    style: mediumTextStyle().copyWith(color: konLightColor1),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              this.course.language,
              style: smallTextStyle()
                  .copyWith(fontSize: 10, color: konLightColor3),
            ),
          ),
          InkWell(
            onTap: (){
              Get.toNamed('/courseDetail');
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                this.course.title,
                style: smallTextStyle()
                    .copyWith(fontSize: 14, color: konDarkColorB1),
              ),
            ),
          ),
          !continueLearing
              ? Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    this.course.instructor_name.toString(),
                    style: smallTextStyle()
                        .copyWith(fontSize: 12, color: konLightColor3),
                  ),
                )
              : Container(),
          !continueLearing
              ? Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        star,
                        height: 15,
                      ),
                      Text(
                        ' 4.5 ',
                        style: buttonTextStyle()
                            .copyWith(fontSize: 12, color: konDarkColorD3),
                      ),
                      Text(
                        ' (1.2k) ',
                        style:
                            mediumTextStyle().copyWith(color: konLightColor3),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
