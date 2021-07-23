import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/task.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class TaskWidget extends StatefulWidget {
  final bool isAuthor;
  final Task task;
  final void Function(Map data) callbackfunc;

  const TaskWidget({Key key, this.isAuthor = false, this.task, this.callbackfunc}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Chip(
                  backgroundColor: konPrimaryColor1,
                  label: Text(
                    widget.task.status != '' && widget.task.status != 'null' && widget.task.status != null?widget.task.status.toString():'Pending',
                    style: mediumTextStyle()
                        .copyWith(fontSize: 10, color: Color(0xffFCFCFF)),
                  ),
                ),
              ),
              Text(
                widget.task.date_added.toString(),
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
              Spacer(),
              widget.task.attachment_url != '' && widget.task.attachment_url != 'null' && widget.task.attachment_url != null?InkWell(
                onTap: () {

                },
                child: Icon(
                  Icons.picture_as_pdf,
                  color: konTextInputBorderActiveColor,
                ),
              ):SizedBox(),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                      Map data = {
                        'task_id': widget.task.id,
                        'action_type': 'delete'
                      };
                      widget.callbackfunc(data);
                },
                child: Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              widget.task.answer != '' && widget.task.answer != 'null'?widget.task.answer.toString():'',
              style: mediumTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB2),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
