import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/course.dart';
import 'package:ilminneed/src/model/lesson.dart';
import 'package:ilminneed/src/model/notes.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/NotesCourseWidget.dart';
import 'package:ilminneed/src/widgets/bookmark_detail.dart';
import 'package:ilminneed/src/widgets/lesson_bottom_value.dart';
import 'package:ilminneed/src/widgets/lesson_content_details.dart';
import 'package:ilminneed/src/widgets/lesson_content_header.dart';
import 'package:ilminneed/src/widgets/lessondetails.dart';
import 'package:ilminneed/src/widgets/message.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:loading_overlay/loading_overlay.dart';

class LessonScreen extends StatefulWidget {
  final String id;
  const LessonScreen({Key key, this.id}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  List<BetterPlayerDataSource> _dataSourceList = [];
  BetterPlayerPlaylistController get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey.currentState.betterPlayerPlaylistController;
  TabController _tabController;
  final TextEditingController _notesctrl = TextEditingController();
  int _tabIndex = 0;
  bool _loading = true;
  List<Lesson> _lesson = new List<Lesson>();
  String title = 'Lessons';
  String author_name = '';
  BetterPlayerConfiguration _betterPlayerConfiguration;
  BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  List<Notes> _notes = new List<Notes>();
  String active_lesson_id = '';
  List<BetterPlayerEvent> events = [];
  bool load_notes = true;

  _fetchlesson() async {
    setState(() {
      _loading = true;
    });
    var res = await ctrl
        .getrequestwithheader('course_lessons/' + widget.id.toString());
    setState(() {
      _loading = false;
      _lesson.clear();
    });
    if (res != null && res != 'null') {
      if (!mounted) return;
      setState(() {
        title = res['course_details'][0]['title'].toString();
        author_name = res['course_details'][0]['first_name'].toString() +
            ' ' +
            res['course_details'][0]['last_name'].toString();
      });
      if (res['courses'].length != 0) {
        List<dynamic> data = res['courses'];
        for (int i = 0; i < data.length; i++) {
          if (!mounted) return;
          setState(() {
            _lesson.add(Lesson.fromJson(data[i]));
          });
          for (int c = 0; c < data[i]['lessons'].length; c++) {
            if (data[i]['lessons'][c]['active'] == true) {
              if (!mounted) return;
              setState(() {
                active_lesson_id = data[i]['lessons'][c]['id'].toString();
              });
            } else if (active_lesson_id == '' && i == 0) {
              if (!mounted) return;
              setState(() {
                active_lesson_id = data[i]['lessons'][c]['id'].toString();
              });
            }
            //https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4
            //https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4
            _dataSourceList.add(
              BetterPlayerDataSource(BetterPlayerDataSourceType.network,
                  data[i]['lessons'][c]['video_url'].toString()),
            );
          }
        }
      }
    }
    if (active_lesson_id != '') {
      _fetchlessonnote();
    }
  }

  _fetchlessonnote() async {
    setState(() {
      load_notes = true;
    });
    var res = await ctrl.getrequestwithheader('bookmarks/' + active_lesson_id);
    print(res);
    setState(() {
      _notes.clear();
      load_notes = false;
    });
    if (res != null && res != 'null') {
      if (res['data'].length != 0) {
        List<dynamic> data = res['data'][0]['notes'];
        for (int i = 0; i < data.length; i++) {
          if (!mounted) return;
          setState(() {
            _notes.add(Notes.fromJson(data[i]));
          });
        }
      }
    }
  }

  _callbackfunc(data) {
    setState(() {
      active_lesson_id = data['lesson_id'];
      _fetchlessonnote();
    });
    _betterPlayerPlaylistController.setupDataSource(data['section_index']);
  }

  _addnotes() async {
    if(_notesctrl.text == '' || _notesctrl.text == null){
      await ctrl.toastmsg('Enter the notes', 'short');
      return;
    }
    Get.back();
    String cv = _betterPlayerPlaylistController.betterPlayerController.videoPlayerController.value.position.toString();
    String v = cv.substring(0, cv.indexOf('.'));
    var parts = v.split(':');
    print(parts.toString());
    var p = (int.parse(parts[0]) * 3600) + (int.parse(parts[1]) * 60) + (int.parse(parts[2]));
    Map data = {
        'duration': p.toString(),
        'lessonId': active_lesson_id.toString(),
        'notes': _notesctrl.text
    };
    setState(() {
      load_notes = true;
    });
    print(data);
    var res = await ctrl.requestwithheader(data,'bookmark/create');
    _fetchlessonnote();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    _betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 1,
      fit: BoxFit.cover,
      placeholderOnTop: true,
      autoPlay: true,
      showPlaceholderUntilPlay: true,
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableAudioTracks: false,
          enableQualities: false,
          progressBarPlayedColor: konPrimaryColor2,
          progressBarHandleColor: konPrimaryColor2,
          skipBackIcon: Icons.replay_10,
          skipForwardIcon: Icons.forward_10,
          forwardSkipTimeInMilliseconds: 10000,
          backwardSkipTimeInMilliseconds: 10000),
      eventListener: (event) {
        print("Better player event: ${event.betterPlayerEventType}");
      },
    );
    _betterPlayerPlaylistConfiguration = BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 1),
    );
    //_betterPlayerPlaylistController.betterPlayerController.addEventsListener(_handlevideoevent);
    _fetchlesson();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    //_betterPlayerPlaylistController?.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  _getFABWidget() {
    switch (_tabIndex) {
      case 0:
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                'More',
                                style: buttonTextStyle().copyWith(
                                    fontSize: 24, color: konDarkColorB1),
                              ),
                              Spacer(),
                              Icon(Icons.close)
                            ],
                          ),
                        ),
                        LessonBottomWidget(
                            value: 'Resources', icon: Icons.download_outlined),
                        LessonBottomWidget(
                            value: 'Certificate', icon: Icons.shield),
                        LessonBottomWidget(value: 'Share', icon: Icons.reply),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.more_vert),
        );
      case 1:
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () async {
            if (_betterPlayerPlaylistController
                .betterPlayerController
                .videoPlayerController
                .value
                .isPlaying) {
              await ctrl.toastmsg(
                  'Pause video and add notes', 'short');
              return;
            }
            setState(() {
              _notesctrl.text = '';
            });
            showModalBottomSheet(
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                InkWell(onTap: ()  {
                                  Get.back();
                                }, child: Icon(Icons.close)),
                                Text(
                                  '@ '+ _betterPlayerPlaylistController
                                      .betterPlayerController
                                      .videoPlayerController
                                      .value.position.toString().substring(0, _betterPlayerPlaylistController
                                      .betterPlayerController
                                      .videoPlayerController
                                      .value.position.toString().indexOf('.')),
                                  style: buttonTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    print(_betterPlayerPlaylistController.betterPlayerController.videoPlayerController.value);
                                    print(_betterPlayerPlaylistController.betterPlayerController.videoPlayerController.value.position);
                                    //return;
                                    if (_betterPlayerPlaylistController
                                        .betterPlayerController
                                        .videoPlayerController
                                        .value
                                        .isPlaying) {
                                      await ctrl.toastmsg(
                                          'Pause video and add notes', 'short');
                                    } else {
                                      _addnotes();
                                    }
                                  },
                                  child: Text(
                                    'Save',
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
          },
          child: Icon(Icons.add),
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.offNamed('/', arguments: 2);
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),
          elevation: 0,
          backgroundColor: konLightColor1,
          title: Text('Lessons'),
          titleSpacing: 0,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: !_loading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    width: double.infinity,
                    height: 220,
                    child: AspectRatio(
                      child: BetterPlayerPlaylist(
                        key: _betterPlayerPlaylistStateKey,
                        betterPlayerConfiguration: _betterPlayerConfiguration,
                        betterPlayerPlaylistConfiguration:
                            _betterPlayerPlaylistConfiguration,
                        betterPlayerDataSourceList: _dataSourceList,
                      ),
                      aspectRatio: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        if (_betterPlayerPlaylistController
                                .betterPlayerController
                                .isPictureInPictureSupported() ==
                            true) {
                          _betterPlayerPlaylistController.betterPlayerController
                              .enablePictureInPicture(
                                  _betterPlayerPlaylistStateKey);
                        } else {
                          print('not supported');
                        }
                      },
                      child: Text(
                        title,
                        softWrap: true,
                        style: largeTextStyle().copyWith(
                            color: konDarkColorB1, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'By ' + author_name.toString(),
                      style: smallTextStyle().copyWith(color: konDarkColorD3),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TabBar(
                      labelPadding: EdgeInsets.symmetric(vertical: 5),
                      controller: _tabController,
                      indicatorColor: konTextInputBorderActiveColor,
                      unselectedLabelStyle:
                          smallTextStyle().copyWith(color: konDarkColorB1),
                      labelStyle:
                          buttonTextStyle().copyWith(color: konDarkColorB1),
                      tabs: <Widget>[
                        Text('Content'),
                        Text('Notes'),
                        Text('Q&A'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Container(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _lesson.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Divider(color: Colors.grey),
                              );
                            },
                            itemBuilder: (context, index) {
                              return LessonDetailWidget(
                                  lesson: _lesson[index],
                                  callbackfunc: _callbackfunc,
                                  index: index,
                                  active_lesson_id: active_lesson_id);
                            },
                          ),
                        ),
                        _notes.length != 0 && !load_notes
                            ? Container(
                                color: Color(0xffF6F5FF),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 7),
                                  itemCount: _notes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return BookMarkDetail(note: _notes[index]);
                                  },
                                ),
                              )
                            : _notes.length == 0 && !load_notes? Container(
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(lesson_empty_notes),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Click on + icon to add notes',
                                    style: mediumTextStyle().copyWith(
                                        fontSize: 15,
                                        color: konDarkColorD3),
                                  ),
                                ],
                              )),
                              ):Container(child: Center(child: const CircularProgressIndicator()), ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 7),
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MessagesWidget(
                                      isAuthor: index == 0,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF6F5FF),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: TextFormField(
                                          style: smallTextStyle()
                                              .copyWith(color: konDarkColorB1),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: Container(
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.attachment_outlined,
                                                      color: konDarkColorD3,
                                                    ),
                                                    SizedBox(width: 15),
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: konDarkColorD3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              hintText:
                                                  'Write your question here',
                                              hintStyle: smallTextStyle()
                                                  .copyWith(
                                                      color: konLightColor3)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: konTextInputBorderActiveColor),
                                      child: Icon(
                                        Icons.mic_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
        floatingActionButton: _getFABWidget(),
      ),
    );
  }
}
