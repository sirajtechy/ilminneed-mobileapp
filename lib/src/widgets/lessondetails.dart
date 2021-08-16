import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/lesson.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/lesson_content_details.dart';

class LessonDetailWidget extends StatefulWidget {
   Lesson lesson;
   void Function(Map data) callbackfunc;
   int index;
   String active_lesson_id;
  LessonDetailWidget({Key key,this.lesson, this.callbackfunc,this.index,this.active_lesson_id}) : super(key: key);

  @override
  _LessonDetailWidgetState createState() => _LessonDetailWidgetState();
}

class _LessonDetailWidgetState extends State<LessonDetailWidget> {

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
                Text('Section ${widget.index+1} - '+widget.lesson.title.toString(),
                    softWrap: true,
                    maxLines: 2,
                    style: titleTextStyle().copyWith(color: konDarkColorB1)
                ),
                SizedBox(height: 8),
                Text(
                  '',
                  style: smallTextStyle().copyWith(color: konDarkColorD3),
                ),
              ],
            ),
            children: <Widget>[
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: widget.lesson.lesson_video.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Divider(color: Colors.grey),
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if(widget.active_lesson_id != widget.lesson.lesson_video[index].id){
                        Map data = {
                          'lesson_index': index,
                          'section_index': widget.index,
                          'lesson_id': widget.lesson.lesson_video[index].id,
                          'source_count': int.parse(widget.lesson.lesson_video[index].source_count)
                        };
                        setState(() {
                          widget.active_lesson_id = widget.lesson.lesson_video[index].id;
                        });
                        widget.callbackfunc(data);
                      }
                    },
                    child: LessonContentDetailsWidget(
                              isActive: widget.active_lesson_id == widget.lesson.lesson_video[index].id?true:false,
                              value: widget.lesson.lesson_video[index].title.toString(),
                              children: [
                                Text('${widget.index+1}/${index+1}',
                                    style: mediumTextStyle()
                                        .copyWith(color: konDarkColorD3)),
                                SizedBox(width: 5),
                                Text(
                                  '.',
                                  style: mediumTextStyle()
                                      .copyWith(color: konDarkColorD3),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.lesson.lesson_video[index].duration.toString(),
                                  style: mediumTextStyle()
                                      .copyWith(color: konDarkColorD3),
                                ),
                              ],
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
