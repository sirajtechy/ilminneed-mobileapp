import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class MessagesWidget extends StatefulWidget {
  final bool isAuthor;

  const MessagesWidget({Key key, this.isAuthor = false}) : super(key: key);

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
                'Adil Basha',
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
                '2 days ago',
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
              Spacer(),
              Icon(
                Icons.delete_outline_outlined,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(
              'Hi all ! put your questions here',
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
                Icon(
                  Icons.favorite_border_outlined,
                  color: konDarkColorB1,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  '(13)',
                  style: mediumTextStyle()
                      .copyWith(fontSize: 10, color: konDarkColorB1),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.mode_comment_outlined,
                  color: konDarkColorB1,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  '(4)',
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
