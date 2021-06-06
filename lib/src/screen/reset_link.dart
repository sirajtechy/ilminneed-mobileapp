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

class ResetLink extends StatelessWidget {
  const ResetLink({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konScaffoldBGColor,
      ),
      backgroundColor: konScaffoldBGColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  reset_link,
                ),
                HeaderTextWidget(label: RESET_LINK),
                HintWidget(label: RESET_LINK_HINT),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextFormField(
                    style: mediumTextStyle()
                        .copyWith(color: konTextInputBorderTextColor),
                    decoration: textFormFieldInputDecoration('abc@gmail.com'),
                  ),
                ),
                ButtonWidget(
                  value: RESEND,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Back to ',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
