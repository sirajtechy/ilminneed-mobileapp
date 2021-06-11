import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/textFieldStyle.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';
import 'package:ilminneed/src/widgets/header_text.dart';
import 'package:ilminneed/src/widgets/hint_text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor2,
      ),
      backgroundColor: konLightColor2,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(forgot_password),
                HeaderTextWidget(label: FORGOT_PASSWORD),
                HintWidget(label: FORGOT_PASSWORD_HINT),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                    style: mediumTextStyle().copyWith(color: konDarkColorB1),
                    decoration: textFormFieldInputDecoration('email'),
                  ),
                ),
                ButtonWidget(
                  value: SEND_LINK,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Back to ',
                        style: smallTextStyle().copyWith(color: konDarkColorB1),
                      ),
                      Text(
                        SIGN_IN,
                        style: buttonTextStyle().copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: konPrimaryColor1,
                            color: konPrimaryColor1),
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
