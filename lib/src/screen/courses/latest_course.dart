import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LatestCourse extends StatelessWidget {
  final Course course;
  final bool isRating;

  const LatestCourse({Key key, this.course, this.isRating = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/courseDetail', arguments: this.course.id);
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                FadeInImage(
                  height: 110,
                  width: 110,
                  placeholder: AssetImage(placeholder),
                  image: this.course.thumbnail.toString()  == null ?
                  Image.asset(placeholder) : NetworkImage(this.course.thumbnail.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width / 1.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      this.course.title.toString(),
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
                  isRating
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
                                style: buttonTextStyle().copyWith(
                                    fontSize: 12, color: konDarkColorD3),
                              ),
                              Text(
                                ' (1.2k) ',
                                style: mediumTextStyle()
                                    .copyWith(color: konLightColor3),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      '\u20B9 ' + this.course.discounted_price.toString(),
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
      ),
    );
  }
}
