import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Apply Coupon',
          style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(12),
              child: TextFormField(
                style: mediumTextStyle()
                    .copyWith(fontSize: 14, color: konLightColor),
                decoration: InputDecoration(
                  hintText: 'Enter coupon code',
                  hintStyle: mediumTextStyle()
                      .copyWith(fontSize: 14, color: konLightColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: konLightColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: konLightColor,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      color: Color(0xffF6F5FF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '15 % off upto Rs.600',
                                  style: largeTextStyle().copyWith(
                                      fontSize: 14, color: konDarkColorB1),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Note : This offer is valid for first buy on;y',
                                  style: mediumTextStyle().copyWith(
                                      fontSize: 10, color: konDarkColorD3),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: DottedBorder(
                                color: konTextInputBorderActiveColor,
                                strokeWidth: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'FIRST',
                                    style: largeTextStyle().copyWith(
                                        fontSize: 14,
                                        color: konTextInputBorderActiveColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )),
            ButtonWidget(
              value: 'Apply',
            )
          ],
        ),
      ),
    );
  }
}
