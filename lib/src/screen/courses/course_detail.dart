import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/comment_rating.dart';
import 'package:ilminneed/src/widgets/course_feature.dart';
import 'package:ilminneed/src/widgets/recent_items.dart';
import 'package:ilminneed/src/widgets/thumbnail.dart';

class CourseDetail extends StatefulWidget {
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: konLightColor1),
        backgroundColor: konDarkColorB1,
        actions: [
          Icon(Icons.shopping_cart, color: konLightColor1),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(Icons.favorite_border, color: konLightColor1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0),
            child: Icon(Icons.share, color: konLightColor1),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 175,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                alignment: Alignment.center,
                child: Text('Video Play preview '),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  'Declarative interfaces for any Apple Devices.. ',
                  softWrap: true,
                  style: largeTextStyle().copyWith(
                      color: konDarkColorB1, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  'Last update 16/12/2020',
                  style: smallTextStyle().copyWith(color: konDarkColorD3),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ratingColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4.5',
                            style: smallTextStyle()
                                .copyWith(fontSize: 12, color: konLightColor1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0, left: 3),
                            child: Icon(
                              Icons.star,
                              size: 13,
                              color: konLightColor1,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '2.5k Reviews',
                      style: buttonTextStyle()
                          .copyWith(color: konTextInputBorderActiveColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '12k Students',
                      style: buttonTextStyle().copyWith(color: konDarkColorB1),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '₹ ',
                      style: largeTextStyle()
                          .copyWith(fontSize: 22, color: konDarkColorB1),
                    ),
                    Text(
                      '1200',
                      style: largeTextStyle()
                          .copyWith(fontSize: 22, color: konDarkColorB1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '1500',
                      style: mediumTextStyle().copyWith(
                          fontSize: 18,
                          color: konDarkColorD3,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '15% off',
                      style: mediumTextStyle()
                          .copyWith(fontSize: 14, color: konGreenColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                color: konLightColor2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.arrow_back),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                      ),
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
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'IT Expert',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 14, color: konDarkColorD3),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'Follow',
                        style: buttonTextStyle().copyWith(
                            fontSize: 16,
                            color: konTextInputBorderActiveColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Description',
                  style: buttonTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB1),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  ABOUT_ME,
                  style: smallTextStyle().copyWith(color: konDarkColorB2),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'Course features',
                  style: buttonTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB1),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CourseFeatureWidget(
                      iconBGColor: Color(0xffE1F7F9),
                      iconColor: Color(0xff1BC76F),
                      value1: 'English',
                      value2: 'cc: Tamil, Arabic',
                      icon: Icons.language,
                    ),
                    CourseFeatureWidget(
                      iconBGColor: Color(0xffFFC5FC),
                      iconColor: Color(0xffBA00EB),
                      value1: '8 video lesson',
                      value2: 'Total 2h 40 min',
                      icon: Icons.play_arrow_outlined,
                    ),
                    CourseFeatureWidget(
                      iconBGColor: Color(0xffFEBED3),
                      iconColor: Color(0xffC73967),
                      value1: '2 Articles',
                      value2: 'Article from design leads',
                      icon: Icons.description_outlined,
                    ),
                  ],
                ),
              ),
              RecentItems(
                label: 'Skills you will gain',
                value: ['UI Design', 'Java', 'Adobe XD', 'Flutter', 'React'],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Related Course',
                        style: buttonTextStyle()
                            .copyWith(fontSize: 16, color: konDarkColorB2),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 2),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ThumbNailWidget(
                              continueLearing: false,
                              course: Course(
                                  id: '1',
                                  title: 'title',
                                  short_description:
                                      'this is a short description',
                                  language: 'Tamil',
                                  price: '2500',
                                  discounted_price: '4500',
                                  thumbnail:
                                      'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
                                  instructor_name: 'Adil Basha',
                                  level: '5'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Ratings and Reviews',
                  style: buttonTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF6F5FF),
                ),
                child: Text('Rating will come here'),
              ),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  CommentRating(
                    rating: 3,
                    name: 'Adil Basha',
                    time: '1 day ago',
                    comment:
                        'Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Vel quam elementum pulvinar etiamnim lobortis scelerisque. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur....',
                  ),
                  CommentRating(
                    rating: 4,
                    name: 'Siraj',
                    time: '5 day ago',
                    comment:
                        'Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Vel quam elementum pulvinar etiamnim lobortis scelerisque. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur....',
                  ),
                  CommentRating(
                    rating: 5,
                    name: 'Basha',
                    time: '3 day ago',
                    comment: 'Awesome , course is good',
                  ),
                  CommentRating(
                    rating: 1,
                    name: 'Ilyas',
                    time: '10 days ago',
                    comment: 'Very bad',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
