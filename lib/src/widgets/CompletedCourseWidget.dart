import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CompletedCourseWidget extends StatefulWidget {
  CompletedCourseWidget({Key key}) : super(key: key);

  @override
  _CompletedCourseWidgetState createState() => _CompletedCourseWidgetState();
}

class _CompletedCourseWidgetState extends State<CompletedCourseWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: konImageBGColor,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('https://via.placeholder.com/140'),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  )
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
          SizedBox(width: 20),
          Expanded(
              child: Column (
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Declarative interfaces for any Apple Devices',
                              softWrap: true,
                              maxLines: 2,
                              style: titleTextStyle().copyWith(color: konDarkColorB1)
                          ),
                          SizedBox(height: 8),
                          Text(
                            'By Siradueen',
                            style: smallTextStyle().copyWith(color: konDarkColorD3),
                          ),
                          SizedBox(height: 10),
                          Text ('Completed', style: titleTextStyle().copyWith(color: konPrimaryColor2)),
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