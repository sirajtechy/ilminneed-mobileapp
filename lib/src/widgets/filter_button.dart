import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: konLightColor2, borderRadius: BorderRadius.circular(5)),
      child: Text(
        label,
        style: smallTextStyle().copyWith(fontSize: 16, color: konDarkColorD3),
      ),
    );
  }
}
