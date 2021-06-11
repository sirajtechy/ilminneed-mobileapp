import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/filter_button.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = const RangeValues(20, 80);
    return Scaffold(
      backgroundColor: konLightColor2,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                width: double.infinity,
                color: konLightColor1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: konLightColor2),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.arrow_back),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.close)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 8),
                      child: SvgPicture.asset(
                        cart,
                        height: 25,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: konLightColor1,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '15 Results found',
                      style: mediumTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          return showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0)),
                              ),
                              backgroundColor: konLightColor2,
                              isScrollControlled: true,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: konLightColor1,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          25.0)),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Filter',
                                                  style: buttonTextStyle()
                                                      .copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Icon(Icons.close),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: konLightColor1,
                                            margin: EdgeInsets.only(top: 2),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            height: 100,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Level',
                                                  style: buttonTextStyle()
                                                      .copyWith(
                                                          color:
                                                              konDarkColorB1),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FilterButton(
                                                        label: 'Beginner'),
                                                    FilterButton(
                                                        label: 'Intermediate'),
                                                    FilterButton(
                                                        label: 'Advanced'),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: konLightColor1,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Price',
                                                  style: buttonTextStyle()
                                                      .copyWith(
                                                          color:
                                                              konDarkColorB1),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RangeSlider(
                                                  inactiveColor:
                                                      rangeInActiveColor,
                                                  activeColor: konPrimaryColor1,
                                                  values: _currentRangeValues,
                                                  min: 0,
                                                  max: 100,
                                                  divisions: 5,
                                                  labels: RangeLabels(
                                                    _currentRangeValues.start
                                                        .round()
                                                        .toString(),
                                                    _currentRangeValues.end
                                                        .round()
                                                        .toString(),
                                                  ),
                                                  onChanged:
                                                      (RangeValues values) {},
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FilterButton(label: '0'),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      FilterButton(
                                                          label: '2500'),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: konLightColor1,
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 20,
                                                right: 20),
                                            height: 100,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Language',
                                                  style: buttonTextStyle()
                                                      .copyWith(
                                                          color:
                                                              konDarkColorB1),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FilterButton(
                                                        label: 'English'),
                                                    FilterButton(
                                                        label: 'Arabic'),
                                                    FilterButton(
                                                        label: 'Tamil'),
                                                    FilterButton(
                                                        label: 'Hindi'),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: konLightColor1,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[300],
                                                    blurRadius: 2.0,
                                                  ),
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          right: BorderSide(
                                                              color:
                                                                  konLightColor2,
                                                              width: 1.5))),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                      child: Text(
                                                    'Reset',
                                                    style: largeTextStyle()
                                                        .copyWith(
                                                            color: Color(
                                                                0xff000000)),
                                                  )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                      child: Text(
                                                    'Reset',
                                                    style: largeTextStyle()
                                                        .copyWith(
                                                            color: Color(
                                                                0xff000000)),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Text(
                          'Filter',
                          style: mediumTextStyle()
                              .copyWith(fontSize: 16, color: konDarkColorB1),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
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
        ),
      ),
    );
  }
}
