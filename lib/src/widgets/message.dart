import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/qanda.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class MessagesWidget extends StatefulWidget {
  final bool isAuthor;
  final QandA qanda;
  final void Function(Map data) callbackfunc;

  const MessagesWidget({Key key, this.isAuthor = false, this.qanda,this.callbackfunc}) : super(key: key);

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {

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
                'user',
                style: buttonTextStyle()
                    .copyWith(fontSize: 12, color: Colors.black),
              ),
              widget.isAuthor
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Chip(
                        backgroundColor: konPrimaryColor1,
                        label: Text(
                          'Author',
                          style: mediumTextStyle()
                              .copyWith(fontSize: 10, color: Color(0xffFCFCFF)),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 10,
                    ),
              Text(
                '',
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Map data = {
                    'qanda_id': widget.qanda.id,
                    'action_type':'delete'
                  };
                  widget.callbackfunc(data);
                },
                child: Icon(
                  Icons.delete_outline_outlined,
                ),
              ),
            ],
          ),
          widget.qanda.attachment_type == 'jpeg' || widget.qanda.attachment_type == 'jpg' || widget.qanda.attachment_type == 'png'?Container (
            margin: EdgeInsets.only(left: 50, bottom: 10),
            width: 150,
            child: Image(
              image: NetworkImage(widget.qanda.attachment_url.toString()),
            ),
          ):SizedBox(),

          widget.qanda.attachment_type == 'pdf' || widget.qanda.attachment_type == 'doc' || widget.qanda.attachment_type == 'docx'?Container (
            margin: EdgeInsets.only(left: 50, bottom: 10),
            width: 50,
            child: Image(
              image: AssetImage(document),
            ),
          ):SizedBox(),

          widget.qanda.audio_attachment != '' && widget.qanda.audio_attachment != 'null' && widget.qanda.audio_attachment != null?InkWell(
            onTap: () {
              Map data = {
                'url': widget.qanda.audio_attachment,
                'action_type':'audio',
              };
              widget.callbackfunc(data);
            },
            child: Container (
              margin: EdgeInsets.only(left: 50, bottom: 10),
              width: 50,
              child: Image(
                image: AssetImage(record_audio),
              ),
            ),
          ):SizedBox(),

          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(
              widget.qanda.question.toString(),
              style: mediumTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB2),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//                Icon(
//                  Icons.favorite_border_outlined,
//                  color: konDarkColorB1,
//                  size: 18,
//                ),
//                SizedBox(width: 5),
//                Text(
//                  '(13)',
//                  style: mediumTextStyle()
//                      .copyWith(fontSize: 10, color: konDarkColorB1),
//                ),
//                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Map data = {
                      'reply': widget.qanda.reply
                    };
                    Get.toNamed('/qandareply', arguments: data);
                  },
                  child: Icon(
                    Icons.mode_comment_outlined,
                    color: konDarkColorB1,
                    size: 18,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '(${widget.qanda.reply.length.toString()})',
                  style: mediumTextStyle()
                      .copyWith(fontSize: 10, color: konDarkColorB1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
