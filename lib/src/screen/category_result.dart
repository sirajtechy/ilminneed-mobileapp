import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/category.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/recent_items.dart';
import 'package:ilminneed/src/widgets/thumbnail.dart';
import 'package:shimmer/shimmer.dart';

class CategoryResultScreen extends StatefulWidget {
  const CategoryResultScreen({Key key}) : super(key: key);

  @override
  _CategoryResultScreenState createState() => _CategoryResultScreenState();
}

class _CategoryResultScreenState extends State<CategoryResultScreen> {
  List<Course> _popularcourse = <Course>[];
  List<CategoryModel> _youmaylike = <CategoryModel>[];

  _fetchpopularcourse() async {
    var res = await ctrl.getrequest({}, 'popular_courses');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        setState(() {
          _popularcourse.add(Course.fromJson(data[i]));
        });
      }
    }
  }

  _fetchyoumaylike() async {
    var res = await ctrl.getrequest({}, 'top_categories');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        setState(() {
          _youmaylike.add(CategoryModel.fromJson(data[i]));
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchpopularcourse();
    _fetchyoumaylike();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Icon(Icons.arrow_back),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/cart');
                      },
                      child: Container(
                        child: SvgPicture.asset(
                          cart,
                          height: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: Text(
                  'Graphic Design',
                  style: largeTextStyle()
                      .copyWith(fontSize: 24, color: konDarkColorB1),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Students pick in the topic',
                    style: ctaTextStyle().copyWith(color: konDarkColorB2),
                  )),
              _popularcourse.length != 0
                  ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: _popularcourse.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ThumbNailWidget(
                                continueLearing: false,
                                course: _popularcourse[index]);
                          },
                        ),
                      ),
                    )
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.2),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.2),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              Container(
                child: _youmaylike.length != 0
                    ? RecentItems(
                        label: 'Related Categories',
                        value: _youmaylike,
                      )
                    : SizedBox(),
              ),
              _popularcourse.length != 0
                  ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 2),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: _popularcourse.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return LatestCourse(course: _popularcourse[index]);
                          },
                        ),
                      ),
                    )
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.2),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.2),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
