import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/cart_bloc.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/banner.dart';
import 'package:ilminneed/src/model/category.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/recent_items.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/thumbnail.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryModel> _youmaylike = new List<CategoryModel>();
  List<CategoryModel> _lookingfor = new List<CategoryModel>();
  List<Course> _popularcourse = new List<Course>();
  List<Course> _continuelearning = new List<Course>();
  List<BannerImg> _slider = new List<BannerImg>();
  final CarouselController _controller = CarouselController();
  int _current = 0;

  _fetchyoumaylike() async {
    var res = await ctrl.getrequest({}, 'top_categories');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _youmaylike.add(CategoryModel.fromJson(data[i]));
        });
      }
    }
  }

  _fetchslider() async {
    var res = await ctrl.getrequest({}, 'explore_image');
    print(res);
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _slider.add(BannerImg.fromJson(data[i]));
        });
      }
    }
  }

  _fetchlookingfor() async {
    var res = await ctrl.getrequest({}, 'top_categories');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _lookingfor.add(CategoryModel.fromJson(data[i]));
        });
      }
    }
  }

  _fetchcontinuelearning() async {
    if(await ctrl.LoggedIn() == true) {
      var res = await ctrl.getrequestwithheader('my_courses');
      print(res);
      if (res != null) {
        List<dynamic> data = res;
        for (int i = 0; i < data.length; i++) {
          if (!mounted) return;
          setState(() {
            _continuelearning.add(Course.fromJson(data[i]));
          });
        }
      }
    }
  }

  _fetchrecentvisit() async {
    if(await ctrl.LoggedIn() == true) {
      var res = await ctrl.getrequestwithheader('recent_courses_visit');
      print(res);
      if (res != null) {
        List<dynamic> data = res;
        for (int i = 0; i < data.length; i++) {
          if (!mounted) return;
          setState(() {
            _continuelearning.add(Course.fromJson(data[i]));
          });
        }
      }
    }
  }

  _fetchpopularcourse() async {
    var res = await ctrl.getrequest({}, 'popular_courses');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        if (!mounted) return;
        setState(() {
          _popularcourse.add(Course.fromJson(data[i]));
        });
      }
    }
  }

  _updatecart() async {
    if(await ctrl.LoggedIn() == true) {
      var res = await ctrl.getrequestwithheader('my_cart');
      var bloc = Provider.of<CartBloc>(context, listen: false);
      if (res != null && res != 'null') {
        if (!mounted) return;
        if(res['courses'].length != 0){
          List<dynamic> data = res['courses'];
          bloc.totalCount(data.length);
        }else{
          bloc.totalCount(0);
        }
      }else{
        bloc.totalCount(0);
      }
    }
  }

  @override
  void initState() {
    _fetchslider();
    _fetchyoumaylike();
    _fetchpopularcourse();
    _fetchcontinuelearning();
    _fetchrecentvisit();
    _fetchlookingfor();
    _updatecart();
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
      backgroundColor: Colors.white,
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
                          ShoppingCartButtonWidget(),
                        ],
                      ),
                    ),
                    Container(
                      height: 175,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),),
                      alignment: Alignment.center,
                      child:  CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });},
                        ),
                        items: _slider
                            .map((item) => Container(
                          child: Center(
                              child:
                              Image.network(item.banner_image, fit: BoxFit.cover,width: double.infinity,)),
                        ))
                            .toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _slider.map((urlOfItem) {
                        int index = _slider.indexOf(urlOfItem);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                        );
                      }).toList(),
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
                    _youmaylike.length !=0?RecentItems(
                      label: 'Categories you may like',
                      value: _youmaylike,
                    ):SizedBox(),
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
                              highlightColor:
                              Colors.grey.withOpacity(0.2),
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
                              highlightColor:
                              Colors.grey.withOpacity(0.2),
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
                    _continuelearning.length != 0
                        ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  CONTINUE_LEARNING,
                                  style: buttonTextStyle().copyWith(
                                      fontSize: 16, color: konDarkColorB2),
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
                                    continueLearing: true,
                                    course: _continuelearning[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    _popularcourse.length != 0
                        ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Topics Your Interested',
                                  style: buttonTextStyle().copyWith(
                                      fontSize: 16, color: konDarkColorB2),
                                ),
//                                Text(
//                                  MY_COURSES,
//                                  style: mediumTextStyle().copyWith(
//                                      fontSize: 16,
//                                      color: konTextInputBorderActiveColor),
//                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 4, bottom: 2),
                            child: SizedBox(
                              height: 215,
                              child: ListView.builder(
                                itemCount: _popularcourse.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ThumbNailWidget(
                                    continueLearing: true,
                                    course: _popularcourse[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(),
                    _lookingfor.length !=0?RecentItems(
                      label: 'Are you looking for',
                      value: _lookingfor,
                    ):SizedBox(),
                    Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Students Recent Visit',
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
                              highlightColor:
                              Colors.grey.withOpacity(0.2),
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
                              highlightColor:
                              Colors.grey.withOpacity(0.2),
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
            ],
          ),
        ),
      ),
    );
  }
}
