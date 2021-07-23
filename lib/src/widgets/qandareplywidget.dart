import 'package:flutter/material.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/qanda.dart';
import 'package:ilminneed/src/model/qandareply.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class QandAReplyWidget extends StatefulWidget {
final QandAReply answer;
  const QandAReplyWidget({Key key,this.answer}) : super(key: key);

  @override
  _QandAReplyWidgetState createState() => _QandAReplyWidgetState();
}

class _QandAReplyWidgetState extends State<QandAReplyWidget> {

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
              CircleAvatar(
                radius: 20,
                child: Icon(Icons.add),
              ),
              SizedBox(width: 10),
              Text(
                '',
                style: buttonTextStyle()
                    .copyWith(fontSize: 13, color: Colors.black),
              ),Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Chip(
                  backgroundColor: konPrimaryColor1,
                  label: Text(
                    'Author',
                    style: mediumTextStyle()
                        .copyWith(fontSize: 12, color: Color(0xffFCFCFF)),
                  ),
                ),
              ),
              Text(
                '',
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
            ],
          ),
          widget.answer.attachment_type == 'jpeg' || widget.answer.attachment_type == 'jpg' || widget.answer.attachment_type == 'png'?Container (
            margin: EdgeInsets.only(left: 50, bottom: 10),
            width: 150,
            child: Image(
              image: NetworkImage(widget.answer.attachment_url.toString()),
            ),
          ):SizedBox(),

          widget.answer.attachment_type == 'pdf' || widget.answer.attachment_type == 'doc' || widget.answer.attachment_type == 'docx'?Container (
            margin: EdgeInsets.only(left: 50, bottom: 10),
            width: 50,
            child: Image(
              image: AssetImage(document),
            ),
          ):SizedBox(),
//
//          widget.qanda.audio_attachment != '' && widget.qanda.audio_attachment != 'null' && widget.qanda.audio_attachment != null?InkWell(
//            onTap: () {
//              Map data = {
//                'url': widget.qanda.audio_attachment,
//                'action_type':'audio',
//              };
//              widget.callbackfunc(data);
//            },
//            child: Container (
//              margin: EdgeInsets.only(left: 50, bottom: 10),
//              width: 50,
//              child: Image(
//                image: AssetImage(record_audio),
//              ),
//            ),
//          ):SizedBox(),

          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(
              widget.answer.answer.toString(),
              style: mediumTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB2),
            ),
          ),
        ],
      ),
    );
  }
}
