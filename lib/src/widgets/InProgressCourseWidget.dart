import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InProgressCourseWidget extends StatefulWidget {
  InProgressCourseWidget({Key key}) : super(key: key);

  @override
  _InProgressCourseWidgetState createState() => _InProgressCourseWidgetState();
}

class _InProgressCourseWidgetState extends State<InProgressCourseWidget> {
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
                          Padding(
                            padding: EdgeInsets.all(0),
                            child:  LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width / 2.5,
                              animation: true,
                              lineHeight: 5.0,
                              animationDuration: 2000,
                              percent: 0.3,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: konPrimaryColor2,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text ('25%', style: titleTextStyle().copyWith(color: konDarkColorB1)),
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