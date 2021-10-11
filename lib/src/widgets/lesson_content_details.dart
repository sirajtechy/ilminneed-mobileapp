import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class LessonContentDetailsWidget extends StatelessWidget {
  final bool isActive;
  final String value;
  final List<Widget>? children;
  final bool lock;

  const LessonContentDetailsWidget(
      {Key? key,
      required this.isActive,
      required this.value,
      this.children,
      this.lock = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isActive ? Color(0xffF6F5FF) : Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: isActive
                    ? mediumTextStyle().copyWith(
                        color: konTextInputBorderActiveColor, fontSize: 16)
                    : smallTextStyle().copyWith(color: konDarkColorB1),
              ),
              SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              )
            ],
          ),
          Spacer(),
          Icon(
            lock?Icons.lock:isActive?Icons.pause_circle_outline:Icons.play_circle_outline_outlined,
          ),
        ],
      ),
    );
  }
}
