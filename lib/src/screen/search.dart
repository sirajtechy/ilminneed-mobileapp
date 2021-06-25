import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/model/courselevel.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _coursename = TextEditingController();
  bool _loading = false;
  List<Course> _course = new List<Course>();
  int pageno = 1;
  bool isLoadingVertical = false;
  bool _current = false;
  bool _loading_finished = false;
  bool _loading_product = true;


  _searchcourse() async {
    if (_current == false && _loading_finished == false) {
      setState(() {
        _current = true;
        isLoadingVertical = true;
      });
      await new Future.delayed(const Duration(seconds: 2));
      Map d = {
        'search': _coursename.text,
        'category': '',
        'level': '',
        'price': '',
        'language': '',
      };
      var oldtxt = _coursename.text;
      var res = await ctrl.requestwithoutheader(d, 'filter_course');
      if (mounted) {
        setState(() {
          _loading_finished = true;
          _loading = false;
          _loading_product = false;
          _current = false;
          isLoadingVertical = false;
        });
      }
      if (res != null) {
        if (oldtxt == _coursename.text) {
          _course.clear();
        }
        List<dynamic> data = res;
        print(data.length.toString());
        for (int i = 0; i < data.length; i++) {
          if (mounted) {
            setState(() {
              _course.add(Course.fromJson(data[i]));
            });
          }
        }
        setState(() {
          pageno++;
        });
      } else {
        if (mounted) {
          setState(() {
            _loading_finished = true;
            _loading = false;
            _loading_product = false;
            _current = false;
            isLoadingVertical = false;
          });
        }
        await ctrl.toastmsg('Error. please try again', 'long');
      }
    } else {
      print('no');
    }
  }

  _filtercourse() {
    setState(() {
      _loading_finished = false;
      _current = false;
    });
    _searchcourse();
  }


  @override
  void initState() {
    _filtercourse();
    super.initState();
  }

  @override
  void dispose() {
    _course?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = const RangeValues(20, 80);
    return Scaffold(
      backgroundColor: konLightColor2,
      body: LoadingOverlay(
        isLoading: _loading,
        child: SafeArea(
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
                            controller: _coursename,
                            onChanged: (v) {
                              setState(() {
                                _course.clear();
                              });
                              _filtercourse();
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      Get.back();
                                    },
                                    child: Icon(Icons.arrow_back)),
                                border: InputBorder.none,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _course.clear();
                                        _coursename.text = '';
                                        _filtercourse();
                                      });
                                    },
                                    child: Icon(Icons.close))),
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
                            CourselevelList _levellist = new CourselevelList();
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
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Spacer(),
                                                  Icon(Icons.close),
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
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: konLightColor1,
                                              height: 60,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: List.generate(
                                                              _levellist.list.length, (index) {
                                                            return Container(
                                                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                              decoration: BoxDecoration(
                                                                  color: konLightColor2, borderRadius: BorderRadius.circular(5)),
                                                              child: Text(
                                                                _levellist.list[index].name.toString(),
                                                                style: smallTextStyle().copyWith(fontSize: 16, color: konDarkColorD3),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ],
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
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: konLightColor1,
                                              height: 60,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: List.generate(
                                                              7, (index) {
                                                            return Container(
                                                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                              decoration: BoxDecoration(
                                                                  color: konLightColor2, borderRadius: BorderRadius.circular(5)),
                                                              child: Text(
                                                                'English',
                                                                style: smallTextStyle().copyWith(fontSize: 16, color: konDarkColorD3),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ],
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
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: konLightColor1,
                                              height: 60,
                                              width: double.infinity,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: List.generate(
                                                              7, (index) {
                                                            return Container(
                                                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                              decoration: BoxDecoration(
                                                                  color: konLightColor2, borderRadius: BorderRadius.circular(5)),
                                                              child: Text(
                                                                'English',
                                                                style: smallTextStyle().copyWith(fontSize: 16, color: konDarkColorD3),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                                    width:
                                                        MediaQuery.of(context)
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
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        !_loading_product && _course.isNotEmpty
                            ? Expanded(
                                child: Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(
                                    left: 15, top: 10, right: 10),
                                color: konLightColor1,
                                child: LazyLoadScrollView(
                                  scrollOffset: 100,
                                  scrollDirection: Axis.vertical,
                                  isLoading: isLoadingVertical,
                                  onEndOfPage: _filtercourse,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _course.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return LatestCourse(
                                          course: _course[index]);
                                    },
                                  ),
                                ),
                              ))
                            : !_loading_product && _course.isEmpty && !_current
                                ? Container(
                                    child: Center(
                                      child: Text(
                                        "Course not found",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : Container(),
                        _current
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Opacity(
                                      opacity: 1.0,
                                      child: new CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
