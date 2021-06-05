import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Widget SocialMediaButton(String svgAsset, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: socialButtonDecoration(),
      width: MediaQuery.of(context).size.width / 2.5,
      height: 50,
      child: Row(
        children: [
          SvgPicture.asset(
            svgAsset,
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style:
                buttonTextStyle().copyWith(color: konTextInputBorderTextColor),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konScaffoldBGColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  signIn,
                ),
                Container(
                  child: Text(
                    SIGN_UP_HEADING,
                    style: largeTextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, left: 15, right: 15),
                  child: Text(
                    SIGN_UP_HINT,
                    textAlign: TextAlign.center,
                    style: mediumTextStyle().copyWith(color: konLightColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                    style: mediumTextStyle()
                        .copyWith(color: konTextInputBorderTextColor),
                    decoration: textFormFieldInputDecoration('name'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    style: mediumTextStyle()
                        .copyWith(color: konTextInputBorderTextColor),
                    decoration: textFormFieldInputDecoration('email'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    style: mediumTextStyle()
                        .copyWith(color: konTextInputBorderTextColor),
                    decoration: textFormFieldInputDecoration('password')
                        .copyWith(suffixIcon: Icon(Icons.visibility)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    color: konTextInputBorderActiveColor,
                  ),
                  child: Center(
                      child: Text(
                        SIGN_UP,
                    style:
                        buttonTextStyle().copyWith(color: konButtonTextColor),
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width / 4,
                        color: konTextInputBorderFillColor,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          SIGN_UP_OPTION,
                          style: smallTextStyle()
                              .copyWith(color: konTextInputBorderFillColor),
                        ),
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width / 4,
                        color: konTextInputBorderFillColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialMediaButton(google, GOOGLE),
                      SocialMediaButton(facebook, FACEBOOK),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ALREADY_MEMBER,
                        style: smallTextStyle()
                            .copyWith(color: konTextInputBorderTextColor),
                      ),
                      Text(
                        SIGN_IN,
                        style: buttonTextStyle().copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: konPinkColor,
                            color: konPinkColor),
                      ),
                    ],
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
