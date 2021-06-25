import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LatestCourse extends StatelessWidget {
  final Course course;
  const LatestCourse({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.all(5),
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(this.course.thumbnail),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    this.course.title,
                    softWrap: true,
                    style: smallTextStyle()
                        .copyWith(fontSize: 14, color: konDarkColorB1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    this.course.instructor_name.toString(),
                    style: smallTextStyle()
                        .copyWith(fontSize: 12, color: konLightColor3),
                  ),
                ),
                Container(
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
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    this.course.discounted_price.toString(),
                    style: mediumTextStyle().copyWith(
                        fontSize: 14,
                        color: konDarkColorB1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
