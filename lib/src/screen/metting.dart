import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/meeting_model.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/metting_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  bool _loading = true;
  List<MeetingModel>? _meetings;

  _fetchmeeting() async {
    var res = await ctrl.getrequestwithheader('meetings');
    if (!mounted) return;
    setState(() {
      _loading = false;
      _meetings?.clear();
    });
    if (res != null && res != 'null' && res.containsKey('data')) {
      if (res['data'].length != 0) {
        if (!mounted) return;
        List<dynamic> data = res['data'];
        for (int i = 0; i < data.length; i++) {
          //print(data[i]);
          if (!mounted) return;
          setState(() {
            _meetings?.add(MeetingModel.fromJson(data[i]));
          });
        }
      }
    }
  }

  checkifloggedin() async {
    if (await ctrl.LoggedIn() == true) {
      _fetchmeeting();
    } else {
      Get.offNamed('/signIn');
    }
  }

  @override
  void initState() {
    checkifloggedin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Meetings',
          style: largeTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        color: Colors.white,
        child: SingleChildScrollView(
            child: _meetings?.length != 0 && !_loading
                ? Column(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _meetings?.length ?? 0,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        },
                        itemBuilder: (context, index) {
                          return MeetingWidget(meeting: _meetings?[index]);
                        },
                      ),
                    ],
                  )
                : _meetings?.length == 0 && !_loading
                    ? Container(
                        child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(lesson_empty_notes),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'No meeting found',
                                  style: mediumTextStyle().copyWith(
                                      fontSize: 15, color: konDarkColorD3),
                                ),
                              ],
                            )),
                      )
                    : Container()),
      ),
    );
  }
}
