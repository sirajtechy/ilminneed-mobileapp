import 'package:flutter/material.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/notes.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class BookMarkDetail extends StatefulWidget {
  final Notes? note;
  final Function(Map data)? callbackfunc;
  final String? lesson_id;

  const BookMarkDetail({Key? key, this.note, this.callbackfunc, this.lesson_id})
      : super(key: key);

  @override
  _BookMarkDetailState createState() => _BookMarkDetailState();
}

class _BookMarkDetailState extends State<BookMarkDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: konLightColor1, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Map data = {
                    'note_id': widget.note!.id,
                    'lesson_id': widget.lesson_id,
                    'duration': int.parse(widget.note!.duration!),
                    'action_type': 'position'
                  };
                  widget.callbackfunc!(data);
                },
                child: Text(
                  widget.note!.note.toString(),
                  style: mediumTextStyle().copyWith(
                    fontSize: 16,
                    color: konTextInputBorderActiveColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  softWrap: true,
                ),
              ),
              Spacer(),
              InkWell(
                onTap:(){
                  Map data = {
                    'note_id': widget.note!.id,
                    'lesson_id': widget.lesson_id,
                    'action_type': 'delete'
                  };
                  widget.callbackfunc!(data);
                },
                child: Icon(
                  Icons.delete,
                  color: konDarkColorB1,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: (){
                  Map data = {
                    'note_id': widget.note!.id,
                    'lesson_id': widget.lesson_id,
                    'action_type': 'edit'
                  };
                  widget.callbackfunc!(data);
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: konDarkColorB1,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: largeTextStyle().copyWith(
                      fontSize: 5,
                      fontWeight: FontWeight.bold,
                      color: konDarkColorB1),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Map data = {
                'note_id': widget.note!.id,
                'lesson_id': widget.lesson_id,
                'duration': int.parse(widget.note!.duration!),
                'action_type': 'position'
              };
              widget.callbackfunc!(data);
            },
            child: Container(
              margin: EdgeInsets.only(top: 7),
              width: double.infinity,
              child: Text(
                widget.note!.duration != 'null' && widget.note!.duration != null
                    ? '@ ' +
                        ctrl.getTimeString(int.parse(widget.note!.duration!))
                    : '',
                style: largeTextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: konDarkColorD3),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            width: double.infinity,
            child: Text(
              '',//13 JUN 2021
              style: mediumTextStyle().copyWith(
                fontSize: 12,
                color: konDarkColorB2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
