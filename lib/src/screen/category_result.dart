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
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:ilminneed/src/widgets/thumbnail.dart';
import 'package:shimmer/shimmer.dart';

class CategoryResultScreen extends StatefulWidget {
  final Map param;
  const CategoryResultScreen({Key key, this.param}) : super(key: key);

  @override
  _CategoryResultScreenState createState() => _CategoryResultScreenState();
}

class _CategoryResultScreenState extends State<CategoryResultScreen> {
  List<Course> _studentpickcourse = <Course>[];
  List<Course> _course = <Course>[];
  List<CategoryModel> _relatedcategory = <CategoryModel>[];

  _fetchcourse() async {
    var res = await ctrl.getrequest({}, 'course_by_category/'+widget.param['id']);
    print(res);
    if (res != null) {
      List<dynamic> spc = res['students_pick'];
      for (int i = 0; i < spc.length; i++) {
        setState(() {
          _studentpickcourse.add(Course.fromJson(spc[i]));
        });
      }

      List<dynamic> cou = res['results'];
      for (int i = 0; i < cou.length; i++) {
        setState(() {
          _course.add(Course.fromJson(cou[i]));
        });
      }

      List<dynamic> cat = res['related_categories'];
      for (int i = 0; i < cat.length; i++) {
        setState(() {
          _relatedcategory.add(CategoryModel.fromJson(cat[i]));
        });
      }

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchcourse();
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
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 0),
                      child: ShoppingCartButtonWidget(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                child: Text(
                  widget.param['name'].toString(),
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
              _studentpickcourse.length != 0
                  ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: _studentpickcourse.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ThumbNailWidget(
                                continueLearing: false,
                                course: _studentpickcourse[index]);
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
                child: _relatedcategory.length != 0
                    ? RecentItems(
                        label: 'Related Categories',
                        value: _relatedcategory,
                      )
                    : SizedBox(),
              ),
              _course.length != 0
                  ? Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 2),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: _course.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return LatestCourse(course: _course[index]);
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
