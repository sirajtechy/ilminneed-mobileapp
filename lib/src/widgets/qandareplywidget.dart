import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/qandareply.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sound/flutter_sound.dart';

class QandAReplyWidget extends StatefulWidget {
final QandAReply answer;
  const QandAReplyWidget({Key key,this.answer}) : super(key: key);

  @override
  _QandAReplyWidgetState createState() => _QandAReplyWidgetState();
}

class _QandAReplyWidgetState extends State<QandAReplyWidget> {
  bool playing = false;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

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
                  widget.answer.first_name.toString()+' '+widget.answer.last_name.toString(),
                style: buttonTextStyle()
                    .copyWith(fontSize: 13, color: Colors.black),
              ),widget.answer.is_instructor == '1'?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Chip(
                  backgroundColor: konPrimaryColor1,
                  label: Text(
                    'Author',
                    style: mediumTextStyle()
                        .copyWith(fontSize: 12, color: Color(0xffFCFCFF)),
                  ),
                ),
              ):SizedBox(),
              Text(
                '',
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
            ],
          ),
          widget.answer.attachment_type == 'jpeg' || widget.answer.attachment_type == 'jpg' || widget.answer.attachment_type == 'png'?InkWell(
            onTap: () async {
              //final _result = await OpenFile.open(widget.qanda.attachment_url.toString());
              Get.toNamed('/viewimage', arguments: widget.answer.attachment_url.toString());
            },
            child: Container (
              margin: EdgeInsets.only(left: 50, bottom: 10),
              width: 150,
              child: Image(
                image: NetworkImage(widget.answer.attachment_url.toString()),
              ),
            ),
          ):SizedBox(),

          widget.answer.attachment_type == 'pdf' || widget.answer.attachment_type == 'doc' || widget.answer.attachment_type == 'docx'?InkWell(
            onTap: () async {
              _launchURL(widget.answer.attachment_url);
            },
            child: Container (
              margin: EdgeInsets.only(left: 50, bottom: 10),
              width: 50,
              child: Image(
                image: AssetImage(document),
              ),
            ),
          ):SizedBox(),

          widget.answer.audio_attachment != '' && widget.answer.audio_attachment != 'null' && widget.answer.audio_attachment != null?InkWell(
            onTap: () {
              _mPlayer.openAudioSession().then((value) {
                if (!_mPlayer.isPlaying == true) {
                  setState(() {
                    playing = true;
                  });
                  _mPlayer
                      .startPlayer(
                      fromURI: widget.answer.audio_attachment,
                      //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
                      whenFinished: () async {
                        setState(() {
                          playing = false;
                        });
                      })
                      .then((value) {});
                } else {
                  _mPlayer.stopPlayer();
                  setState(() {
                    playing = false;
                  });
                }
              });
            },
            child: Container (
              margin: EdgeInsets.only(left: 50, bottom: 10),
              width: 50,
              child: Icon(!playing?Icons.play_circle_filled:Icons.pause_circle_filled),
            ),
          ):SizedBox(),

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
