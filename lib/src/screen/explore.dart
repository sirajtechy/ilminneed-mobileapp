import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/model/category.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/screen/welcome.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import '../widgets/thumbnail.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:shimmer/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryModel> _topcategory = new List<CategoryModel>();
  List<Course> _popularcourse = new List<Course>();
  List<Course> _continuelearning = new List<Course>();

  _fetchtopcategory() async {
    var res = await ctrl.getrequest({}, 'top_categories');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        setState(() {
          _topcategory.add(CategoryModel.fromJson(data[i]));
        });
      }
    }
  }

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

  @override
  void initState() {
    _fetchtopcategory();
    _fetchpopularcourse();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget chipContainer(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: konLightColor2),
      child: Text(
        label,
        style: smallTextStyle().copyWith(color: konBlackColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: SvgPicture.asset(
                              cart,
                              height: 35,
                            ),
                          ),
                          Text(
                            'Explore',
                            style: buttonTextStyle()
                                .copyWith(fontSize: 18, color: konDarkColorB1),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WelcomeScreen())),
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        onTap: () {
                          Get.toNamed('/search');
                        },
                        style:
                            mediumTextStyle().copyWith(color: konDarkColorB1),
                        decoration:
                            searchTextFormFieldInputDecoration(SEARCH_COURSES)
                                .copyWith(suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _topcategory.length != 0
                        ? Container(
                      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                      height: 50.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: List.generate(
                                      _topcategory.length, (index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          color: konLightColor2),
                                      child: Text(
                                        _topcategory[index].name.toString(),
                                        style: smallTextStyle()
                                            .copyWith(color: konBlackColor),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed('/category');
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      border: Border.all(
                                          color: konLightColor3)),
                                  child: Text(
                                    'View All +',
                                    style: smallTextStyle()
                                        .copyWith(color: konLightColor3),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                chipContainer('            '),
                                chipContainer('            '),
                                chipContainer('            '),
                                chipContainer('            '),
                              ],
                            ),
                          )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            POPULAR,
                            style: buttonTextStyle()
                                .copyWith(fontSize: 16, color: konDarkColorB2),
                          ),
                          Text(
                            VIEW_ALL,
                            style: mediumTextStyle().copyWith(
                                fontSize: 16,
                                color: konTextInputBorderActiveColor),
                          )
                        ],
                      ),
                    ),
                    _popularcourse.length != 0
                        ? Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 8, bottom: 2),
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
                                child: Container (
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
                                child: Container (
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
              _continuelearning.length!=0?Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            CONTINUE_LEARNING,
                            style: buttonTextStyle()
                                .copyWith(fontSize: 16, color: konDarkColorB2),
                          ),
                          Text(
                            MY_COURSES,
                            style: mediumTextStyle().copyWith(
                                fontSize: 16,
                                color: konTextInputBorderActiveColor),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 4, bottom: 2),
                      child: SizedBox(
                        height: 215,
                        child: ListView.builder(
                          itemCount: _continuelearning.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ThumbNailWidget(
                              continueLearing: true, course: _continuelearning[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
