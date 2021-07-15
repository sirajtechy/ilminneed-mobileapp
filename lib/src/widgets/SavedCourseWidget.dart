import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SavedCourseWidget extends StatefulWidget {
  final String status;
  final Course course;
  SavedCourseWidget({Key key,this.status, this.course}) : super(key: key);

  @override
  _SavedCourseWidgetState createState() => _SavedCourseWidgetState();
}

class _SavedCourseWidgetState extends State<SavedCourseWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/lesson', arguments: widget.course.id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                  FadeInImage(
                    height: 120,
                    width: 120,
                    placeholder: AssetImage(placeholder),
                    image: widget.course.thumbnail.toString()  == null ?
                    Image.asset(placeholder) : NetworkImage(widget.course.thumbnail.toString()),
                    fit: BoxFit.cover,
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
                    widget.course.course_duration.toString().replaceAll(RegExp('Hours'), ''),
                    style: mediumTextStyle().copyWith(color: konLightColor1),
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 15),
          Expanded(
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              widget.course.title.toString(),
                              softWrap: true,
                              maxLines: 2,
                              style: titleTextStyle().copyWith(color: konDarkColorB1)
                          ),
                          SizedBox(height: 8),
                          Text(
                            'By '+widget.course.instructor_name.toString(),
                            style: smallTextStyle().copyWith(color: konDarkColorD3),
                          ),
                          SizedBox(height: 10),
                          widget.status == 'saved'?Text ('Start Learning', style: titleTextStyle().copyWith(color: konPrimaryColor2)):SizedBox(),
                          widget.status == 'progress'?Padding(
                            padding: EdgeInsets.all(0),
                            child:  LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width / 2.5,
                              animation: true,
                              lineHeight: 5.0,
                              animationDuration: 2000,
                              percent: widget.course.completion / 100,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: konPrimaryColor2,
                            ),
                          ):SizedBox(),
                          widget.status == 'progress'?SizedBox(height: 10):SizedBox(),
                          widget.status == 'progress'?Text (widget.course.completion.toString()+'%', style: titleTextStyle().copyWith(color: konDarkColorB1)):SizedBox(),
                          widget.status == 'completed'?Text ('Completed', style: titleTextStyle().copyWith(color: konPrimaryColor2)):SizedBox(),
                        ],
                      )
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}