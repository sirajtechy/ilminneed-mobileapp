import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            style: buttonTextStyle(konTextInputBorderTextColor),
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
                SvgPicture.asset(signIn),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    CONTINUE_LEARNING,
                    style: largeTextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    SIGN_IN_HINT,
                    style: mediumTextStyle(konLightColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                    style: mediumTextStyle(konTextInputBorderTextColor),
                    decoration: textFormFieldInputDecoration('email'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    style: mediumTextStyle(konTextInputBorderTextColor),
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
                    SIGN_IN,
                    style: buttonTextStyle(konButtonTextColor),
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
                      FORGOT_PASSWORD,
                      style: buttonTextStyle(konTextInputBorderActiveColor),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
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
                          SIGN_IN_OPTION,
                          style: smallTextStyle(konTextInputBorderFillColor),
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
                        NEW_MEMBER,
                        style: smallTextStyle(konTextInputBorderTextColor),
                      ),
                      Text(
                        CREATE_ACCOUNT,
                        style: buttonTextStyle(konPinkColor).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: konPinkColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
