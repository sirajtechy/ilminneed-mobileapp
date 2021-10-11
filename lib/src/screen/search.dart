import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/category.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/model/courselevel.dart';
import 'package:ilminneed/src/model/pricelist.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  final String? term;

  const SearchScreen({Key? key, this.term}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _coursename = TextEditingController();
  bool _loading = false;
  List<Course>? _course;

  List<CategoryModel>? _category;

  int filter = 0;
  List<String>? recent_history;

  String? _filter_level = '';
  String _filter_category = '';
  String? _filter_price = '';
  int pageno = 1;
  bool isLoadingVertical = false;
  bool _current = false;
  bool _loading_product = true;
  int? total_result = 0;
  bool load_more = true;

  _fetchcategory() async {
    await _getRecentSearchesLike('');
    var res = await ctrl.getrequest({}, 'categories');
    setState(() {
      _loading = false;
    });
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        _category?.add(CategoryModel.fromJson(data[i]));
      }
    }
  }

  _searchcourse(search) async {
    if (_course?.length == total_result && _course?.length != 0 && !search) {
      await ctrl.toastmsg('No more course found', 'short');
      return;
    }
    print(filter.toString());
    setState(() {
      _current = true;
      isLoadingVertical = true;
    });
    if (search) {
      setState(() {
        _course?.clear();
        pageno = 1;
      });
    }
    await new Future.delayed(const Duration(seconds: 3));
    Map d = {
      'search': _coursename.text,
      'category': _filter_category,
      'level': _filter_level,
      'price': _filter_price,
      'language': '',
    };
    var oldtxt = _coursename.text;
    var res = await ctrl.requestwithoutheader(
        d, 'filter_course/' + pageno.toString());
    if (!mounted) return;
    setState(() {
      _loading = false;
      _loading_product = false;
      _current = false;
      isLoadingVertical = false;
    });
    if (res != null) {
      if (search) {
        if (!mounted) return;
        setState(() {
          _course?.clear();
          pageno = 1;
        });
      }
      List<dynamic> data = res[0]['courses'];
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _course?.add(Course.fromJson(data[i]));
        });
      }
      if (_coursename.text != '') {
        await _saveToRecentSearches(_coursename.text);
      }
      if (!mounted) return;
      setState(() {
        pageno++;
        recent_history?.clear();
        total_result = res[0]['total_results'];
        print(total_result.toString());
      });
    } else {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loading_product = false;
        _current = false;
        isLoadingVertical = false;
      });
      await ctrl.toastmsg('Error. please try again', 'long');
    }
  }

  _showfiltermodal() {
    CourselevelList _levellist = new CourselevelList();
    PriceLists _pricelist = new PriceLists();
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: konLightColor2,
        isScrollControlled: true,
        //isDismissible: false,
        //enableDrag: false,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return Wrap(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: konLightColor1,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25.0)),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filter',
                              style: buttonTextStyle().copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                      Container(
                        color: konLightColor1,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Level',
                              style: buttonTextStyle()
                                  .copyWith(color: konDarkColorB1),
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
                                        _levellist.list!.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          mystate(() {
                                            if (_filter_level == '') {
                                              filter++;
                                            }
                                            _filter_level =
                                                _levellist.list![index].id;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: _filter_level ==
                                                  _levellist.list![index].id
                                                  ? konPrimaryColor1
                                                  : konLightColor2,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            _levellist.list![index].name
                                                .toString(),
                                            style: smallTextStyle().copyWith(
                                                fontSize: 16,
                                                color: _filter_level ==
                                                    _levellist
                                                            .list![index].id
                                                    ? konLightColor1
                                                    : konDarkColorD3),
                                          ),
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
                            top: 10, bottom: 10, left: 20, right: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category',
                              style: buttonTextStyle()
                                  .copyWith(color: konDarkColorB1),
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
                                        _category?.length ?? 0, (index) {
                                      return InkWell(
                                        onTap: () {
                                          mystate(() {
                                            if (_filter_category == '') {
                                              filter++;
                                            }
                                            _filter_category =
                                                _category![index].id.toString();
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: _filter_category ==
                                                  _category![index]
                                                          .id
                                                          .toString()
                                                  ? konPrimaryColor1
                                                  : konLightColor2,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            _category![index].name.toString(),
                                            style: smallTextStyle().copyWith(
                                                fontSize: 16,
                                                color: _filter_category ==
                                                        _category![index]
                                                            .id
                                                            .toString()
                                                    ? konLightColor1
                                                    : konDarkColorD3),
                                          ),
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
                            top: 10, bottom: 10, left: 20, right: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: buttonTextStyle()
                                  .copyWith(color: konDarkColorB1),
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
                                        _pricelist.list!.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          mystate(() {
                                            if (_filter_price == '') {
                                              filter++;
                                            }
                                            _filter_price =
                                                _pricelist.list![index].id;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: _filter_price ==
                                                  _pricelist.list![index].id
                                                          .toString()
                                                  ? konPrimaryColor1
                                                  : konLightColor2,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            _pricelist.list![index].name
                                                .toString(),
                                            style: smallTextStyle().copyWith(
                                                fontSize: 16,
                                                color: _filter_price ==
                                                    _pricelist
                                                            .list![index].id
                                                            .toString()
                                                    ? konLightColor1
                                                    : konDarkColorD3),
                                          ),
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
                      filter != 0
                          ? Container(
                              decoration: BoxDecoration(
                                  color: konLightColor1,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.greenAccent[200]!,
                                      offset: const Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _filter_price = '';
                                          _filter_level = '';
                                          _filter_category = '';
                                          filter = 0;
                                        });
                                        Get.back();
                                        _searchcourse(true);
                                      },
                                      child: Center(
                                          child: Text(
                                        'Reset',
                                        style: ctaTextStyle()
                                            .copyWith(color: Color(0xff000000)),
                                      )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: konLightColor2,
                                                width: 1.5))),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.back();
                                        _searchcourse(true);
                                      },
                                      child: Center(
                                          child: Text(
                                        'Apply',
                                        style: ctaTextStyle()
                                            .copyWith(color: konPrimaryColor),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            );
          });
        });
  }

  _removefromhistory(rs) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches")!;
    allSearches.removeWhere((element) => element == rs);
    pref.setStringList("recentSearches", allSearches.toList());
    setState(() {
      recent_history = allSearches;
    });
  }

  Future<List<String>?>? _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    if (allSearches != null) {
      if (query != '') {
        setState(() {
          recent_history =
              allSearches.where((search) => search.startsWith(query)).toList();
        });
      } else {
        setState(() {
          recent_history = allSearches.toList();
        });
      }
    }
  }

  Future<void> _saveToRecentSearches(String searchText) async {
    if (searchText == null) return;
    final pref = await SharedPreferences.getInstance();
    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};
    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  @override
  void initState() {
    _fetchcategory();
    if (widget.term != '' && widget.term != 'null' && widget.term != null) {
      recent_history?.clear();
      _coursename.text = widget.term.toString();
      _searchcourse(true);
    }
    // _filtercourse();
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
        color: Colors.white,
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
                            onChanged: (v) async {
                              await _getRecentSearchesLike(v);
                              _searchcourse(true);
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
                                suffixIcon: _coursename.text != ''
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _coursename.text = '';
                                          });
                                          _searchcourse(true);
                                        },
                                        child: Icon(Icons.close))
                                    : SizedBox()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 8),
                        child: ShoppingCartButtonWidget(),
                      )
                    ],
                  ),
                ),
                recent_history?.length != 0
                    ? Container(
                        width: double.infinity,
                        color: konLightColor1,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent',
                              style: mediumTextStyle().copyWith(
                                  fontSize: 16, color: konDarkColorB1),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                recent_history?.length != 0
                    ? ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: recent_history?.length ?? 0,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            color: konLightColor1,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          size: 15.0,
                                        ),
                                        SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _coursename.text =
                                                  recent_history![index]
                                                      .toString();
                                              recent_history?.clear();
                                            });
                                            _searchcourse(true);
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: recent_history?[index]
                                                      .toString(),
                                                  style: mediumTextStyle()
                                                      .copyWith(
                                                          color:
                                                              konPrimaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          _removefromhistory(
                                              recent_history?[index]
                                                  .toString());
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.black, size: 15)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(),
                Container(
                  color: konLightColor1,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _course?.length != 0
                          ? Text(
                              total_result.toString(),
                              style: mediumTextStyle().copyWith(
                                  fontSize: 16, color: konPrimaryColor),
                            )
                          : SizedBox(),
                      _course?.length != 0
                          ? Text(
                              ' Results found',
                              style: mediumTextStyle().copyWith(
                                  fontSize: 16, color: konDarkColorB1),
                            )
                          : SizedBox(),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            _showfiltermodal();
                          },
                          child: Text(
                            filter != 0
                                ? '(' + filter.toString() + ') Filter'
                                : 'Filter',
                            style: mediumTextStyle().copyWith(
                                fontSize: 16,
                                color: filter != 0
                                    ? konPrimaryColor
                                    : konDarkColorB1),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        !_loading_product && _course!.isNotEmpty
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
                                  onEndOfPage: () {
                                    _searchcourse(false);
                                  },
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _course?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return LatestCourse(
                                          course: _course?[index]);
                                    },
                                  ),
                                ),
                              ))
                            : !_loading_product && _course!.isEmpty && !_current
                                ? Container(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Image(
                                              image: AssetImage(search),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'No results found',
                                              style: largeTextStyle().copyWith(
                                                  fontSize: 32,
                                                  color: konDarkBlackColor),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Search with other keys',
                                              style: mediumTextStyle().copyWith(
                                                  fontSize: 15,
                                                  color: konDarkColorD3),
                                            ),
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text: "Or browse the  ",
                                                    style: TextStyle(
                                                        color: konDarkColorD3)),
                                                TextSpan(
                                                    recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Get.offNamed('/',
                                                                  arguments: 1),
                                                    text: "categories",
                                                    style: TextStyle(
                                                        color: konPrimaryColor2,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                            ),
                                          ],
                                        )),
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
