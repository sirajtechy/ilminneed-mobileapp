import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/meeting_model.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingWidget extends StatefulWidget {
  MeetingModel? meeting;

  MeetingWidget({Key? key, this.meeting}) : super(key: key);

  @override
  _MeetingWidgetState createState() => _MeetingWidgetState();
}

class _MeetingWidgetState extends State<MeetingWidget> {

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: size.width - 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 25,
                  spreadRadius: 1,
                  color: Color(0xFFD3D3D3).withOpacity(.5),
                ),
              ],
            ),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: new EdgeInsets.only(left: 0, right: 0, bottom: 5.0),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: new BoxDecoration(
                    color: new Color(0xFFFFFFFF),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Color(0xFF007363).withOpacity(0.10),
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 5.0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.meeting!.name.toString(),
                              style: buttonTextStyle()
                                  .copyWith(color: konDarkColorB1),
                            ),
                          InkWell(
                                onTap: () {
                                  _launchURL(widget.meeting!.link);
                                },
                                child: Text(
                                  'Join Meeting',
                                  style: buttonTextStyle().copyWith(
                                      color: konTextInputBorderActiveColor),
                                ))
                          ],
                      ),
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Start Date & Time', style: button2TextStyle().copyWith(color: konDarkColorB2)
                              ),
                              Text(
                                '${widget.meeting!.sdate} ${widget.meeting!.stime}',
                                  style: button2TextStyle()
                                      .copyWith(color: konDarkColorD3),
                                ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'End Date & Time',
                                  style: button2TextStyle().copyWith(color: konDarkColorB2)),
                                Text(
                                  '${widget.meeting!.edate} ${widget.meeting!.etime}',
                                  style: button2TextStyle()
                                      .copyWith(color: konDarkColorD3),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Course: ${widget.meeting!.course.toString()}",
                          style: button2TextStyle()
                              .copyWith(color: konDarkColorB1),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password: ${widget.meeting!.apassword}",
                              style: button2TextStyle()
                                  .copyWith(color: konDarkColorB1),
                            ),
                            Text(
                              "Status: ${widget.meeting!.status}",
                              style: button2TextStyle()
                                  .copyWith(color: konDarkColorB1),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
