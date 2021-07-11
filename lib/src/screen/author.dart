import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/author.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/screen/courses/latest_course.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:loading_overlay/loading_overlay.dart';

class AuthorScreen extends StatefulWidget {
  final String id;
  const AuthorScreen({Key key,this.id}) : super(key: key);

  @override
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {

  bool _loading = true;
  Author _author = new Author();
  List<Course> _authorcourse = new List<Course>();

  _authordetails() async {
    var res = await ctrl.getrequest({}, 'instructor_details/'+widget.id);
    if (res != null) {
      if (!mounted) return;
      setState(() {
        Author _data = new Author.fromJson(res);
        _author = _data;
      });
      List<dynamic> re = res.containsKey('courses')?res['courses']:[];
      for (int i = 0; i < re.length; i++) {
        if (!mounted) return;
        setState(() {
          _authorcourse.add(Course.fromJson(re[i]));
        });
      }
    setState(() {
      _loading = false;
    });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _authordetails();
    super.initState();
  }

  Widget _coursesColumn(count,label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count.toString(),
          style: buttonTextStyle().copyWith(
              fontSize: 18,
              color: konTextInputBorderActiveColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          label.toString(),
          style:
              mediumTextStyle().copyWith(fontSize: 14, color: konDarkColorB1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Author'),
        elevation: 0,
        titleSpacing: 0.0,
        backgroundColor: konLightColor1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.share),
          )
        ],
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        child: SingleChildScrollView(
          child: !_loading?Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                color: konLightColor1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.arrow_back),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _author.first_name +' '+_author.last_name,
                            style: buttonTextStyle().copyWith(
                                fontSize: 18,
                                color: konDarkColorB1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '',
                            style: mediumTextStyle()
                                .copyWith(fontSize: 14, color: konDarkColorD3),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: Color(0xffF6F5FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _coursesColumn(_author.total_course,'Course'),
                    _coursesColumn(_author.total_students,'Students'),
                    _coursesColumn(_author.review_count,'Reviews'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: konLightColor1,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About me',
                      style: buttonTextStyle().copyWith(
                          fontSize: 16,
                          color: konDarkColorB1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
//                    Html(
//                      data: "",
//                    ),
                    Text(
                      'About Me',
                      style: smallTextStyle().copyWith(color: konDarkColorB2),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                    //Html(data: _author.biography),
                  ],
                ),
              ),
              _authorcourse.length != 0?Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 15, top: 10, right: 10),
                color: konLightColor1,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _authorcourse.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LatestCourse(
                      course: _authorcourse[index]
                    );
                  },
                ),
              ):Container()
            ],
          ):Container(),
        ),
      ),
    );
  }
}
