import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ThumbNailWidget extends StatelessWidget {
  final bool? continueLearing;
  final Course? course;

  const ThumbNailWidget({Key? key, this.continueLearing, this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print(this.course.id); return;
        if (this.course!.is_purchased == 'true' ||
            this.course!.is_purchased == '1') {
          Get.toNamed('/lesson', arguments: this.course!.id);
        } else {
          Get.toNamed('/courseDetail', arguments: this.course!.id);
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                  FadeInImage(
                    height: 120,
                    placeholder: AssetImage(placeholder),
                    image: this.course!.thumbnail.toString() == null ||
                            this.course!.thumbnail.toString() == 'null'
                        ? Image.asset(placeholder) as ImageProvider<Object>
                        : NetworkImage(this.course!.thumbnail.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
//                Container(
//                  height: 120,
//                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                  decoration: BoxDecoration(
//                          color: konImageBGColor,
//                    image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: this.course.thumbnail!='null'?NetworkImage(this.course.thumbnail.toString()):AssetImage(placeholder),
//                    ),
//                          borderRadius: BorderRadius.circular(8),
//                        )
//                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: konDarkColorB2),
                    child: Text(
                      this
                          .course!
                          .course_duration
                          .toString()
                          .replaceAll(RegExp('Hours'), ''),
                      style: mediumTextStyle().copyWith(color: konLightColor1),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                this.course!.language.toString(),
                style: smallTextStyle()
                    .copyWith(fontSize: 10, color: konLightColor3),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                this.course!.title.toString(),
                style: smallTextStyle()
                    .copyWith(fontSize: 14, color: konDarkColorB1),
              ),
            ),
            !continueLearing!
                ? Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      this.course!.instructor_name.toString(),
                      style: smallTextStyle()
                          .copyWith(fontSize: 12, color: konLightColor3),
                    ),
                  )
                : Container(),
            !continueLearing! && this.course!.rating != 'null'
                ? Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          star,
                          height: 15,
                        ),
                        Text(
                          this.course!.rating.toString(),
                          style: buttonTextStyle()
                              .copyWith(fontSize: 12, color: konDarkColorD3),
                        ),
                        Text(
                          '(${this.course!.number_of_ratings.toString()})',
                          style:
                              mediumTextStyle().copyWith(color: konLightColor3),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
