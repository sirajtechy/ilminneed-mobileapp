import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

import 'courses/latest_course.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 5,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LatestCourse(
                            isRating: false,
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
                                level: '5')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Remove',
                              style: mediumTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            ),
                            SizedBox(width: 30),
                            Icon(Icons.favorite_border_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Move to wishlist',
                              style: mediumTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: konDarkColorB4,
                    thickness: 1,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/coupon');
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(12),
                color: Color(0xffF6F5FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '%',
                      style: largeTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB2),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Apply coupon',
                      style: largeTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB2),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('Price details',
                  style: largeTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB2)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total course',
                          style: mediumTextStyle()
                              .copyWith(fontSize: 16, color: konDarkBlackColor),
                        ),
                        Spacer(),
                        Text('₹ 18,568',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 14, color: konDarkColorB1))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total course',
                          style: mediumTextStyle()
                              .copyWith(fontSize: 16, color: konDarkBlackColor),
                        ),
                        Spacer(),
                        Text('₹ 18,568',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 14, color: konDarkColorB1))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total course',
                          style: mediumTextStyle()
                              .copyWith(fontSize: 16, color: konDarkBlackColor),
                        ),
                        Spacer(),
                        Text('₹ 18,568',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 14, color: konDarkColorB1))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: konDarkColorB4, thickness: 1),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: mediumTextStyle()
                        .copyWith(fontSize: 16, color: konDarkBlackColor),
                  ),
                  Spacer(),
                  Text('₹ 18,568',
                      style: mediumTextStyle()
                          .copyWith(fontSize: 14, color: konDarkColorB1))
                ],
              ),
            ),
            Divider(color: konDarkColorB4, thickness: 1),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('My wishlist',
                  style: largeTextStyle()
                      .copyWith(fontSize: 16, color: konDarkColorB2)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 2,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LatestCourse(
                            isRating: false,
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
                                level: '5')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Remove',
                              style: mediumTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            ),
                            SizedBox(width: 30),
                            Icon(Icons.favorite_border_outlined),
                            SizedBox(width: 10),
                            Text(
                              'Move to wishlist',
                              style: mediumTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: konDarkColorB4,
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
