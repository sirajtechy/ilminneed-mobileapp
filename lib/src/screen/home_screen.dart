import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

import '../widgets/thumbnail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Widget chipContainer(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: konScaffoldBGColor),
      child: Text(
        label,
        style: smallTextStyle().copyWith(color: konBlackColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konScaffoldBGColor,
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
                            style: buttonTextStyle().copyWith(
                                fontSize: 18,
                                color: konTextInputBorderTextColor),
                          ),
                          Container(
                            child: SvgPicture.asset(
                              cart,
                              height: 35,
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
                        style: mediumTextStyle()
                            .copyWith(color: konTextInputBorderTextColor),
                        decoration:
                            searchTextFormFieldInputDecoration(SEARCH_COURSES)
                                .copyWith(suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          chipContainer('Business'),
                          chipContainer('Design'),
                          chipContainer('Lifestyle'),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: konTextInputBorderFillColor)),
                            child: Text(
                              'View All +',
                              style: smallTextStyle()
                                  .copyWith(color: konTextInputBorderFillColor),
                            ),
                          )
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
                            style: buttonTextStyle().copyWith(
                                fontSize: 16, color: konBlackTextColor),
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
                            );
                          },
                        ),
                      ),
                    ),
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
                            CONTINUE_LEARNING,
                            style: buttonTextStyle().copyWith(
                                fontSize: 16, color: konBlackTextColor),
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
                          left: 15, right: 15, top: 8, bottom: 2),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ThumbNailWidget(
                              continueLearing: true,
                            );
                          },
                        ),
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
