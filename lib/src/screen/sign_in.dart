import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:ilminneed/src/widgets/header_text.dart';
import 'package:ilminneed/src/widgets/hint_text.dart';
import 'package:get/get.dart';

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
            style: buttonTextStyle().copyWith(color: konDarkColorB1),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(signIn),
                HeaderTextWidget(label: CONTINUE_LEARNING),
                HintWidget(label: SIGN_IN_HINT),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                    style: mediumTextStyle().copyWith(color: konDarkColorB1),
                    decoration: textFormFieldInputDecoration('email'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    style: mediumTextStyle().copyWith(color: konDarkColorB1),
                    decoration: textFormFieldInputDecoration('password')
                        .copyWith(suffixIcon: Icon(Icons.visibility)),
                  ),
                ),
                ButtonWidget(
                  value: SIGN_IN,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/forgotPassword');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        FORGOT_PASSWORD,
                        style: buttonTextStyle()
                            .copyWith(color: konTextInputBorderActiveColor),
                      ),
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
                        color: konLightColor3,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          SIGN_IN_OPTION,
                          style:
                              smallTextStyle().copyWith(color: konLightColor3),
                        ),
                      ),
                      Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width / 4,
                        color: konLightColor3,
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
                InkWell(
                  onTap: () {
                    Get.offAllNamed('/signUp');
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          NEW_MEMBER,
                          style: smallTextStyle().copyWith(color: konDarkColorB1),
                        ),
                        Text(
                          CREATE_ACCOUNT,
                          style: buttonTextStyle().copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: konPrimaryColor1,
                              color: konPrimaryColor1),
                        ),
                      ],
                    ),
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
