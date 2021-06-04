import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle largeTextStyle() {
  return GoogleFonts.dmSans(
      fontSize: 24, fontWeight: FontWeight.w700, color: konBlackColor);
}

TextStyle mediumTextStyle(Color color) {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: color,
  );
}

TextStyle buttonTextStyle(Color color) {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: color,
  );
}

TextStyle smallTextStyle(Color color) {
  return GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: color,
  );
}
