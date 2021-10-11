import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/lesson.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/lesson_content_details.dart';

class CourseLessonMetaWidget extends StatefulWidget {
  Lesson? sections;
  int? index;

  CourseLessonMetaWidget({Key? key, this.sections, this.index})
      : super(key: key);

  @override
  _CourseLessonMetaWidgetState createState() => _CourseLessonMetaWidgetState();
}

class _CourseLessonMetaWidgetState extends State<CourseLessonMetaWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            iconColor: Colors.black,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.sections!.title.toString(),
                    softWrap: true,
                    maxLines: 2,
                    style: titleTextStyle().copyWith(color: konDarkColorB1)),
                SizedBox(height: 8),
                Text(
                  '',
                  style: smallTextStyle().copyWith(color: konDarkColorD3),
                ),
              ],
            ),
            children: <Widget>[
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: widget.sections!.lesson_video!.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Divider(color: Colors.grey),
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: LessonContentDetailsWidget(
                      isActive: true,
                      value: widget.sections!.lesson_video![index].title
                          .toString(),
                      children: [
                        Text('${widget.index! + 1}/${index + 1}',
                            style: mediumTextStyle()
                                .copyWith(color: konDarkColorD3)),
                        SizedBox(width: 5),
                        Text(
                          '.',
                          style:
                              mediumTextStyle().copyWith(color: konDarkColorD3),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.sections!.lesson_video![index].duration
                              .toString(),
                          style:
                              mediumTextStyle().copyWith(color: konDarkColorD3),
                        ),
                      ],
                      lock: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
