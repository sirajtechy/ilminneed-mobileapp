import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/model/review.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/comment_rating.dart';
import 'package:ilminneed/src/widgets/course_feature.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:ilminneed/src/widgets/testing.dart';
import 'package:ilminneed/src/widgets/thumbnail.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CourseDetail extends StatefulWidget {
  final String id;
  const CourseDetail({Key key, this.id}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  bool _loading = true;
  bool _first = true;
  Course _course = new Course();
  List<Review> _review = new List<Review>();
  List<Course> _relatedcourse = new List<Course>();
  var res;
  int total_lesson;
  double star_5 = 0;
  double star_4 = 0;
  double star_3 = 0;
  double star_2 = 0;
  double star_1 = 0;

  _fetchcourse() async {
    if (await ctrl.LoggedIn() == true) {
      res = await ctrl.getrequestwithheader('course/' + widget.id);
    } else {
      res = await ctrl.getrequest({}, 'course/' + widget.id);
    }
    if (res != null) {
      setState(() {
        Course _data = new Course.fromJson(res[0]);
        _course = _data;
      });
      List<dynamic> re = res[0].containsKey('reviews') ? res[0]['reviews'] : [];
      for (int i = 0; i < re.length; i++) {
        if (!mounted) return;
        setState(() {
          _review.add(Review.fromJson(re[i]));
        });
      }
      var rating = res[0].containsKey('number_of_ratings_basedon') ? res[0]['number_of_ratings_basedon'] : '';
      if(rating != ''){
        setState(() {
          star_5 = double.parse(res[0]['number_of_ratings_basedon']['5_stars'].toString());
          star_4 = double.parse(res[0]['number_of_ratings_basedon']['4_stars'].toString());
          star_3 = double.parse(res[0]['number_of_ratings_basedon']['3_stars'].toString());
          star_2 = double.parse(res[0]['number_of_ratings_basedon']['2_stars'].toString());
          star_1 = double.parse(res[0]['number_of_ratings_basedon']['1_stars'].toString());
        });
      }
      setState(() {
        _loading = false;
        _first = false;
      });
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
    final double sliderWidth = MediaQuery.of(this.context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: konLightColor1)),
        backgroundColor: konDarkColorB1,
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ShoppingCartButtonWidget(c: 'white')),
          InkWell(
            onTap: () async {
              if (await ctrl.LoggedIn() == true) {
                setState(() {
                  _loading = true;
                });
                await ctrl.addtowishlist(_course.id);
                _fetchcourse();
              } else {
                await ctrl.toastmsg('Login to add wishlist', 'short');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: _course.is_wishlisted == 'true'?Icon(Icons.favorite, color: Colors.red):Icon(Icons.favorite_border, color: konLightColor1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8.0),
            child: Icon(Icons.share, color: konLightColor1),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        child: !_first
            ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 175,
                        margin: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(_course.thumbnail.toString()),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AutoFullscreenOrientationPage()));
                          },
                          child: FlatButton(
                            color: Colors.black.withOpacity(0.5),
                            shape: StadiumBorder(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text('Play preview',
                                    style: buttonTextStyle()
                                        .copyWith(color: konLightColor1))
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AutoFullscreenOrientationPage()));
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          _course.title.toString(),
                          softWrap: true,
                          style: largeTextStyle().copyWith(
                              color: konDarkColorB1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Last update ' + _course.last_edited, //16/12/2020
                          style:
                              smallTextStyle().copyWith(color: konDarkColorD3),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                    _course.rating,
                                    style: smallTextStyle().copyWith(
                                        fontSize: 12, color: konLightColor1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1.0, left: 3),
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
                              _course.number_of_ratings.toString() + ' Reviews',
                              style: buttonTextStyle().copyWith(
                                  color: konTextInputBorderActiveColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
//                      Text(
//                        '12k Students',
//                        style: buttonTextStyle().copyWith(color: konDarkColorB1),
//                      ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ',
                              style: largeTextStyle().copyWith(
                                  fontSize: 22, color: konDarkColorB1),
                            ),
                            Text(
                              _course.discounted_price.toString(),
                              style: largeTextStyle().copyWith(
                                  fontSize: 22, color: konDarkColorB1),
                            ),
                            SizedBox(width: 10),
                            Text(
                              _course.price.toString(),
                              style: mediumTextStyle().copyWith(
                                  fontSize: 18,
                                  color: konDarkColorD3,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: 10),
                            _course.discount_flag.toString() != '' &&
                                    _course.discount_flag.toString() != 'null'
                                ? Text(
                                    _course.discount_flag.toString(),
                                    style: mediumTextStyle().copyWith(
                                        fontSize: 14, color: konGreenColor),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        color: konLightColor2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed('/author',
                                    arguments: _course.user_id);
                              },
                              child: CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/author',
                                    arguments: _course.user_id);
                              },
                              child: Container(
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
                                          _course.instructor_name.toString(),
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
                                      '',
                                      style: mediumTextStyle().copyWith(
                                          fontSize: 14, color: konDarkColorD3),
                                    ),
                                  ],
                                ),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          'Description',
                          style: buttonTextStyle()
                              .copyWith(fontSize: 16, color: konDarkColorB1),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text(
                          _course.short_description.toString(),
                          style:
                              smallTextStyle().copyWith(color: konDarkColorB2),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text(
                          'Course features',
                          style: buttonTextStyle()
                              .copyWith(fontSize: 16, color: konDarkColorB1),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Column (
                          children: [
                            CourseFeatureWidget(
                              iconBGColor: Color(0xffE1F7F9),
                              iconColor: Color(0xff1BC76F),
                              value1: 'English',
                              value2: '', //cc: Tamil, Arabic,
                              icon: Icons.language,
                            ),
                            CourseFeatureWidget(
                              iconBGColor: Color(0xffFFC5FC),
                              iconColor: Color(0xffBA00EB),
                              value1: _course.total_lessons.toString() +
                                  ' video lesson',
                              value2: 'Total ' + _course.course_duration,
                              icon: Icons.play_arrow_outlined,
                            ),
//                      CourseFeatureWidget(
//                        iconBGColor: Color(0xffFEBED3),
//                        iconColor: Color(0xffC73967),
//                        value1: '2 Articles',
//                        value2: 'Article from design leads',
//                        icon: Icons.description_outlined,
//                      ),
                            CourseFeatureWidget(
                              iconBGColor: Color(0xffFEBED3),
                              iconColor: Color(0xffC73967),
                              value1: 'Quiz',
                              value2: 'With ' +
                                  _course.total_number_of_quizzes.toString() +
                                  ' Questions',
                              icon: Icons.description_outlined,
                            ),
                            _course.is_certificate != 'no'
                                ? CourseFeatureWidget(
                              iconBGColor: Color(0xffFEBED3),
                              iconColor: Color(0xffC73967),
                              value1: 'Certificate',
                              value2: 'For course completion',
                              icon: Icons.description_outlined,
                            )
                                : SizedBox(),
                          ],
                        )
                      ),
//              RecentItems(
//                label: 'Skills you will gain',
//                value: ['UI Design', 'Java', 'Adobe XD', 'Flutter', 'React'],
//              ),
                      _relatedcourse.length != 0
                          ? Container(
                              margin: EdgeInsets.only(bottom: 10),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      'Related Course',
                                      style: buttonTextStyle().copyWith(
                                          fontSize: 16, color: konDarkColorB2),
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
                            )
                          : SizedBox(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          'Ratings and Reviews',
                          style: buttonTextStyle()
                              .copyWith(fontSize: 16, color: konDarkColorB2),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        height: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 140,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _course.rating.toString(),
                                      style: largeTextStyle().copyWith(
                                          fontSize: 45, color: konDarkColorB1),
                                    ),
                                    RatingBar.builder(
                                      initialRating: double.parse(_course.rating),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemSize: 20,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: null,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      _course.number_of_ratings+' Verified Buyers',
                                      style: mediumTextStyle()
                                          .copyWith(color: konDarkColorD3),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomSlider(
                                      percentage: star_5 / 100,
                                      width: 5,
                                    ),
                                    CustomSlider(
                                      percentage: star_4 / 100,
                                      width: 4,
                                    ),
                                    CustomSlider(
                                      percentage: star_3 / 100,
                                      width: 3,
                                    ),
                                    CustomSlider(
                                      percentage: star_2 / 100,
                                      width: 2,
                                    ),
                                    CustomSlider(
                                      percentage: star_1 / 100,
                                      width: 1,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _review.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        },
                        itemBuilder: (context, index) {
                          return CommentRating(
                              rating: double.parse(_review[index].rating),
                              name: _review[index].first_name,
                              time: _review[index].date_added.toString(),
                              comment: _review[index].review.toString());
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
      bottomNavigationBar: !_first
          ? Padding(
              padding: EdgeInsets.all(0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: konTextInputBorderActiveColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          topLeft: Radius.circular(0)),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.15),
                            offset: Offset(0, -2),
                            blurRadius: 5.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () async {
                                if (await ctrl.LoggedIn() == true) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  var res = await ctrl.addtocart(
                                      _course.id, this.context);
                                  if (res) {
                                    _fetchcourse();
                                  }
                                } else {
                                  Get.offAllNamed('/signIn', arguments: {
                                    'name': '/courseDetail',
                                    'arg': _course.id
                                  });
                                }
                              },
                              shape: StadiumBorder(),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              color: konLightColor1,
                              child: Text(
                                'Buy now & Unlock the course',
                                textAlign: TextAlign.left,
                                style: ctaTextStyle().copyWith(
                                    color: konTextInputBorderActiveColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _course.is_carted == 'true'
                                ? Icons.check_circle
                                : Icons.shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            _course.is_carted == 'true' ? 'Added to cart' : 'Add to cart',
                            style: buttonTextStyle()
                                .copyWith(color: konLightColor1),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double percentage;
  final int width;
  CustomSlider({
    this.percentage, this.width
  });
  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 20,
            child: Text (this.width.toString(), style: buttonTextStyle())
        ),
        SizedBox(width: 10),
        Expanded(child: Stack(
          children: [
            new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width / 2.5,
              lineHeight: 8.0,
              percent: percentage,
              progressColor: konPrimaryColor,
            ),
          ],
        ))
      ],
    );
  }
}
