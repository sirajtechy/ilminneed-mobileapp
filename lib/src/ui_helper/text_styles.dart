import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle largeTextStyle() {
  return GoogleFonts.dmSans(
      fontSize: 24, fontWeight: FontWeight.w700, color: konBlackColor);
}

TextStyle ctaTextStyle() {
  return GoogleFonts.dmSans(
      fontSize: 16, fontWeight: FontWeight.w700, color: konBlackColor);
}

TextStyle mediumTextStyle() {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
}

TextStyle buttonTextStyle() {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
}

TextStyle smallTextStyle() {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
