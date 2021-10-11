import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/task.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskWidget extends StatefulWidget {
  final bool isAuthor;
  final Task? task;
  final void Function(Map data)? callbackfunc;

  const TaskWidget(
      {Key? key, this.isAuthor = false, this.task, this.callbackfunc})
      : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Chip(
                  backgroundColor: widget.task!.status == 'retake'
                      ? Colors.orange
                      : widget.task!.status == 'approved'
                          ? Colors.green
                          : Colors.redAccent,
                  label: Text(
                    widget.task!.status != '' &&
                            widget.task!.status != 'null' &&
                            widget.task!.status != null
                        ? widget.task!.status.toString().toUpperCase()
                        : 'PENDING',
                    style: mediumTextStyle()
                        .copyWith(fontSize: 10, color: Color(0xffFCFCFF)),
                  ),
                ),
              ),
              Text(
                widget.task!.date_added.toString(),
                style: buttonTextStyle()
                    .copyWith(fontSize: 10, color: konDarkColorD3),
              ),
              Spacer(),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Map data = {
                    'task_id': widget.task!.id,
                    'action_type': 'delete'
                  };
                  widget.callbackfunc!(data);
                },
                child: Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
          widget.task!.attachment_type == 'jpeg' ||
                  widget.task!.attachment_type == 'jpg' ||
                  widget.task!.attachment_type == 'png'
              ? InkWell(
                  onTap: () async {
                    //final _result = await OpenFile.open(widget.qanda.attachment_url.toString());
                    Get.toNamed('/viewimage',
                        arguments: widget.task!.attachment_url.toString());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 50, bottom: 10),
                    width: 150,
                    child: Image(
                      image:
                          NetworkImage(widget.task!.attachment_url.toString()),
                    ),
                  ),
          ):SizedBox(),

          widget.task!.attachment_type == 'pdf' ||
                  widget.task!.attachment_type == 'doc' ||
                  widget.task!.attachment_type == 'docx'
              ? InkWell(
                  onTap: () async {
                    _launchURL(widget.task!.attachment_url);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 50, bottom: 10),
                    width: 50,
                    child: Image(
                      image: AssetImage(document),
                    ),
                  ),
                ):SizedBox(),

          widget.task!.audio_attachment != '' &&
                  widget.task!.audio_attachment != 'null' &&
                  widget.task!.audio_attachment != null
              ? InkWell(
                  onTap: () {
                    _mPlayer.openAudioSession().then((value) {
                      if (!_mPlayer.isPlaying == true) {
                        setState(() {
                          playing = true;
                        });
                        _mPlayer
                            .startPlayer(
                                fromURI: widget.task!.audio_attachment,
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
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              widget.task!.answer != '' && widget.task!.answer != 'null'
                  ? widget.task!.answer.toString()
                  : '',
              style: mediumTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB2),
            ),
          ),
        ],
      ),
    );
  }
}
