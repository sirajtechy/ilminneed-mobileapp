import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/widgets/course_lesson_meta.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CourseLesson extends StatefulWidget {
  final Map data;
  const CourseLesson({Key key,this.data}) : super(key: key);

  @override
  _CourseLessonState createState() => _CourseLessonState();
}

class _CourseLessonState extends State<CourseLesson> {
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
            child: Icon(Icons.arrow_back, color: konLightColor1)),
        backgroundColor: konDarkColorB1,
        title: Text ('Lessons', style: TextStyle(color: Colors.white)),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    widget.data['course_name'].toString(),
                    softWrap: true,
                    style: titleTextStyle().copyWith(
                        color: konDarkColorB1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.data['sections'].length,
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.grey.withOpacity(0.5));
                    },
                    itemBuilder: (context, index) {
                      return CourseLessonMetaWidget(sections: widget.data['sections'][index],index: index);
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
