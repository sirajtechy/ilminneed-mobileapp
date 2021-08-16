import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/model/lessonnote.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/NotesCourseWidget.dart';
import 'package:ilminneed/src/widgets/SavedCourseWidget.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:loading_overlay/loading_overlay.dart';

class MyCourses extends StatefulWidget {
  String data = '0';

  MyCourses({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  bool _loading = true;
  String total_course = '0';
  String learned_time = '';
  String quiz_attended = '0';
  String total_certificate = '0';
  List<Course> _progress = new List<Course>();
  List<Course> _saved = new List<Course>();
  List<Course> _completed = new List<Course>();
  List<LessonNote> _lessonnote = new List<LessonNote>();
  bool empty = false;
  bool load_note = true;
  bool _firsttime = true;
  final TextEditingController _notesctrl = TextEditingController();

  _fetchcourse() async {
    var res = await ctrl.getrequestwithheader('my_courses');
    if (!mounted) return;
      setState(() {
        _firsttime = false;
        _loading = false;
        _progress.clear();
        _saved.clear();
        _completed.clear();
      });
    if (res != null && res != 'null' && res.containsKey('my_courses')) {
      if (res['my_courses'].length != 0) {
        if (!mounted) return;
        setState(() {
          total_course = res['course_enrolled'].toString();
          learned_time = res['learned_time']['hours'].toString() +
              'h ' +
              res['learned_time']['minutes'].toString() +
              'm';
          total_certificate = res['course_certificates'].toString();
        });
        List<dynamic> data = res['my_courses'];
        for (int i = 0; i < data.length; i++) {
          //print(data[i]['in_progress']);
          //print(data[i]['completion']);
          //print(data[i]);
          if (!mounted) return;
          setState(() {
            if (data[i]['in_progress'] == true && data[i]['completion'] == 0) {
              _progress.add(Course.fromJson(data[i]));
            }else if (data[i]['in_progress'] != true && data[i]['completion'] == 0) {
              _saved.add(Course.fromJson(data[i]));
            } else if (data[i]['completion'] == 100) {
              _completed.add(Course.fromJson(data[i]));
            }else if (data[i]['completion'] != 0 && data[i]['completion'] != 100) {
              _progress.add(Course.fromJson(data[i]));
            }else{
              _saved.add(Course.fromJson(data[i]));
            }
          });
        }
      } else {
        setState(() {
          empty = true;
        });
      }
    } else {
      setState(() {
        empty = true;
      });
    }
  }

  _fetchlessonnote() async {
    var res = await ctrl.getrequestwithheader('bookmarks_by_user');
    if (!mounted) return;
    setState(() {
      _lessonnote.clear();
      load_note = false;
      _loading = false;
    });
    if (res != null && res != 'null' && res.length != 0) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
       // print(data[i]);
        if (!mounted) return;
        setState(() {
          _lessonnote.add(LessonNote.fromJson(data[i]));
        });
      }
    }
  }

  checkifloggedin() async {
    if (await ctrl.LoggedIn() == true) {
      if(widget.data != ''){
        setState(() {
          _tabIndex = int.parse(widget.data);
        });
      }

      _tabController =
          TabController(length: 4, initialIndex: _tabIndex, vsync: this);
      _tabController.addListener(_handleTabSelection);
      _fetchcourse();
      _fetchlessonnote();
    } else {
      Get.offNamed('/signIn');
    }
  }

  _callbackfunc(data) async {
    if (data['action_type'] == 'delete') {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(""),
          content: Text(
            "Are you sure you want to delete this note?",
            style: button2TextStyle().copyWith(color: konDarkColorD3),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                "CANCEL",
                style: buttonTextStyle().copyWith(color: konPrimaryColor1),
              ),
            ),
            FlatButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                setState(() {
                  _loading = true;
                });
                var res =
                    await ctrl.requestwithheader(data, 'bookmarks_delete');
                _fetchlessonnote();
              },
              child: Text(
                "DELETE",
                style: buttonTextStyle().copyWith(color: konPrimaryColor1),
              ),
            ),
          ],
        ),
      );
    } else if (data['action_type'] == 'edit') {
      setState(() {
        _loading = true;
      });
      var res = await ctrl.requestwithheader(data, 'bookmarks_edit_note_by_id');
      setState(() {
        _loading = false;
      });
      if (res != null && res != 'null' && res.containsKey('lesson_id')) {
        setState(() {
          _notesctrl.text = res['note'];
        });
        Map data = {
          'lesson_id': res['lesson_id'],
          'note_id': res['id'],
          'note': _notesctrl.text,
        };
        return showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.close)),
                            Text(
                              '@ ' + res['duration'] != 'null' && res['duration'] != null?ctrl.getTimeString(int.parse(res['duration'])):'',
                              style: buttonTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                data['note'] = _notesctrl.text;
                                setState(() {
                                  _loading = true;
                                });
                                Get.back();
                                var res = await ctrl.requestwithheader(data, 'bookmarks_update_note_by_id');
                                _fetchlessonnote();
                              },
                              child: Text(
                                'Update',
                                style: smallTextStyle().copyWith(
                                    color: konTextInputBorderActiveColor,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _notesctrl,
                          // expands: true,
                          //autofocus: true,
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }
    }
  }

  @override
  void initState() {
    checkifloggedin();
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = 100;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.offNamed('/', arguments: { 'currentTab': 0,'data':'' });
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        elevation: 0,
        backgroundColor: konLightColor1,
        title: Text('My Courses'),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10),
            child: ShoppingCartButtonWidget(),
          )
        ],
      ),
      key: _scaffoldKey,
      body: LoadingOverlay(
        color: Colors.white,
        isLoading: _loading,
        child: !_firsttime && !empty
            ? CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 0, left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: konLightColor4,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.2)),
                                    bottom: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.3)),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage(hat)),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(total_course,
                                            style: largeTextStyle()),
                                        Text('My Courses',
                                            style: buttonTextStyle())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.2)),
                                    bottom: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.3)),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage(clock)),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(learned_time,
                                            style: largeTextStyle()),
                                        Text('Learned time',
                                            style: buttonTextStyle())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.2)),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage(quiz)),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(quiz_attended,
                                            style: largeTextStyle()),
                                        Text('Quiz Attended',
                                            style: buttonTextStyle())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color:
                                            Colors.grey.withOpacity(0.2)),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage(certificate)),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(total_certificate.toString(),
                                            style: largeTextStyle()),
                                        Text('Certificates',
                                            style: buttonTextStyle())
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  labelColor: konLightColor1,
                  unselectedLabelColor: konBlackColor,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(0), // Creates border
                      color: konPrimaryColor2),
                  tabs: [
                    Tab(text: 'Saved'),
                    Tab(text: 'In Progress'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Notes'),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                  _saved.length != 0
                      ? Container(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _saved.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return SavedCourseWidget(
                                  status: 'saved',
                                  course: _saved[index]);
                            },
                          )
                        )
                      : Container(
                          child: Center(
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Image(
                                      width: 50,
                                      height: 50,
                                      image: AssetImage(mycourse_empty),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'No saved course',
                                      style: largeTextStyle().copyWith(
                                          fontSize: 15, color: konDarkColorD3),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                )),
                          ),
                        ),
                  _progress.length != 0
                      ? Container(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _progress.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return SavedCourseWidget(
                            status: 'progress',
                            course: _progress[index]);
                      },
                    ),
                  )
                      : Container(
                    child: Center(
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Image(
                                width: 50,
                                height: 50,
                                image: AssetImage(mycourse_empty),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'No progress course',
                                style: largeTextStyle().copyWith(
                                    fontSize: 15, color: konDarkColorD3),
                              ),
                              SizedBox(height: 5),
                            ],
                          )),
                    ),
                  ),
                  _completed.length != 0
                      ? Container(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _completed.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return SavedCourseWidget(
                                  status: 'completed',
                                  course: _completed[index]);
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Image(
                                      width: 50,
                                      height: 50,
                                      image: AssetImage(mycourse_empty),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'No completed course',
                                      style: largeTextStyle().copyWith(
                                          fontSize: 15, color: konDarkColorD3),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                )),
                          ),
                        ),
                  _lessonnote.length != 0 && !load_note
                      ? Container(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _lessonnote.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Divider(color: Colors.grey),
                              );
                            },
                            itemBuilder: (context, index) {
                              return NotesCourseWidget(
                                  lessonnote: _lessonnote[index],
                                  callbackfunc: _callbackfunc);
                            },
                          ),
                        )
                      : _lessonnote.length == 0 && !load_note
                          ? Container(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            lesson_empty_notes),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Notes not found',
                                        style: mediumTextStyle().copyWith(
                                            fontSize: 15,
                                            color: konDarkColorD3),
                                      ),
                                    ],
                                  )),
                            )
                          : Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                  ],
                ),
              ),
            ])
            : !_firsttime && empty
                ? Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage(mycourse_empty),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Start learning',
                              style: largeTextStyle().copyWith(
                                  fontSize: 32, color: konDarkBlackColor),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'To find course progress',
                              style: mediumTextStyle().copyWith(
                                  fontSize: 15, color: konDarkColorD3),
                            ),
                          ],
                        )),
                  )
                : Container(),
      ),
    );
  }
}
