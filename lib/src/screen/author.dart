import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({Key key}) : super(key: key);

  Widget _coursesColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1208',
          style: buttonTextStyle().copyWith(
              fontSize: 18, color: konDarkColorB1, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Course',
          style:
              mediumTextStyle().copyWith(fontSize: 14, color: konDarkColorB1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      appBar: AppBar(
        title: Text('Author'),
        elevation: 0,
        titleSpacing: 0.0,
        backgroundColor: konLightColor1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.share),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            color: konLightColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.arrow_back),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Shamshudeen',
                            style: buttonTextStyle().copyWith(
                                fontSize: 18,
                                color: konDarkColorB1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Follow',
                            style: buttonTextStyle().copyWith(
                                fontSize: 16,
                                color: konTextInputBorderActiveColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'IT Expert',
                        style: mediumTextStyle()
                            .copyWith(fontSize: 14, color: konDarkColorD3),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            color: konLightColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _coursesColumn(),
                _coursesColumn(),
                _coursesColumn(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: konLightColor1,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About me',
                  style: buttonTextStyle().copyWith(
                      fontSize: 16,
                      color: konDarkColorB1,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ABOUT_ME,
                  style: smallTextStyle().copyWith(color: konDarkColorB2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.only(left: 15, top: 10, right: 10),
              color: konLightColor1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return LatestCourse();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
