import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor1,
        title: Text(
          'Account',
          style:
              buttonTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 5,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: konTextInputBorderActiveColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'Adil Basha',
                style: buttonTextStyle()
                    .copyWith(fontSize: 18, color: konDarkColorB1),
              )),
              SizedBox(height: 10),
              Center(
                  child: Text(
                'adil@gmail.com',
                style: smallTextStyle()
                    .copyWith(fontSize: 18, color: konDarkColorB2),
              )),
              SizedBox(height: 50),
              Text(
                'Settings',
                style: smallTextStyle()
                    .copyWith(fontSize: 12, color: konLightColor),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Support',
                style: smallTextStyle()
                    .copyWith(fontSize: 12, color: konLightColor),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Security',
                      style: smallTextStyle()
                          .copyWith(fontSize: 16, color: konDarkColorB1),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_outlined, color: konLightColor),
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
