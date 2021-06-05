import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

import 'colors.dart';

InputDecoration textFormFieldInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 25,
    ),
    hintText: hintText,
    hintStyle: mediumTextStyle().copyWith(color: konLightColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(65.0),
      ),
      borderSide: BorderSide(color: konTextInputBorderActiveColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(65.0),
      borderSide: BorderSide(
        color: konTextInputBorderFillColor,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(65.0),
      borderSide: BorderSide(
        color: konTextInputBorderErrorColor,
        width: 1.0,
      ),
    ),
  );
}

InputDecoration searchTextFormFieldInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 25,
    ),
    hintText: hintText,
    hintStyle: mediumTextStyle().copyWith(color: konLightColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: konTextInputBorderActiveColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: konTextInputBorderFillColor,
        width: 1.0,
      ),
    ),
  );
}

BoxDecoration socialButtonDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: konButtonTextColor,
      boxShadow: [
        BoxShadow(
          color: konScaffoldBGColor,
          offset: const Offset(
            5.0,
            5.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),
      ]);
}
