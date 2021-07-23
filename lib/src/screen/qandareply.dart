import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/widgets/course_lesson_meta.dart';
import 'package:ilminneed/src/widgets/qandareplywidget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class QandAReplyScreen extends StatefulWidget {
  final Map data;
  const QandAReplyScreen({Key key, this.data}) : super(key: key);

  @override
  _QandAReplyScreenState createState() => _QandAReplyScreenState();
}

class _QandAReplyScreenState extends State<QandAReplyScreen> {
  bool _loading = false;
  Course _course = new Course();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double sliderWidth = MediaQuery.of(this.context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: konBlackColor)),
        backgroundColor: Colors.white,
        title: Text (widget.data['reply'].length.toString()+' Replies', style: TextStyle(color: konBlackColor)),
      ),
      body: LoadingOverlay(
        color: Colors.white,
        isLoading: _loading,
        child:  Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.data['reply'].length,
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.grey);
                    },
                    itemBuilder: (context, index) {
                      return QandAReplyWidget(answer: widget.data['reply'][index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
