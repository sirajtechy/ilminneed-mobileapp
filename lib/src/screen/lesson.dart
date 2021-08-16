import 'dart:convert';
import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/model/lesson.dart';
import 'package:ilminneed/src/model/notes.dart';
import 'package:ilminneed/src/model/qanda.dart';
import 'package:ilminneed/src/model/task.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/bookmark_detail.dart';
import 'package:ilminneed/src/widgets/lesson_bottom_value.dart';
import 'package:ilminneed/src/widgets/lessondetails.dart';
import 'package:ilminneed/src/widgets/message.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/widgets/task_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

typedef _Fn = void Function();
const theSource = AudioSource.microphone;

class LessonScreen extends StatefulWidget {
  final String id;
  const LessonScreen({Key key, this.id}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  //recording
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  final String _mPath = 'ilminneed_voice_record.wav';
  //recording

  List<BetterPlayerDataSource> _dataSourceList = [];
  List _dataSourceListIds = [];
  BetterPlayerPlaylistController get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey.currentState.betterPlayerPlaylistController;
  TabController _tabController;
  final TextEditingController _notesctrl = TextEditingController();
  final TextEditingController _qandactrl = TextEditingController();
  final TextEditingController _taskctrl = TextEditingController();
  int _tabIndex = 0;
  bool _loading = true;
  bool _firsttime = true;
  bool load_task = true;
  String task_file = '';
  List<Lesson> _lesson = new List<Lesson>();
  String title = 'Lessons';
  String author_name = '';
  String q_camera = '';
  String q_camera_extension = '';
  String q_camera_preview = '';
  String q_doc_preview = '';
  String q_audio_preview = '';
  String q_gallery = '';
  String q_gallery_extension = '';
  String q_gallery_preview = '';
  String q_doc = '';
  String q_doc_extension = '';
  String q_voice = '';
  String q_voice_extension = '';

  //task
  String t_camera = '';
  String t_camera_extension = '';
  String t_camera_preview = '';
  String t_doc_preview = '';
  String t_audio_preview = '';
  String t_gallery = '';
  String t_gallery_extension = '';
  String t_gallery_preview = '';
  String t_doc = '';
  String t_doc_extension = '';
  String t_voice = '';
  String t_voice_extension = '';
  //task

  FlutterSound flutterSound = new FlutterSound();
  bool recording = false;
  BetterPlayerConfiguration _betterPlayerConfiguration;
  BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  List<Notes> _notes = new List<Notes>();
  List<Task> _task = new List<Task>();
  List<QandA> _qanda = new List<QandA>();
  String active_lesson_id = '';
  List<BetterPlayerEvent> events = [];
  bool load_notes = true;
  bool load_qanda = true;
  bool pauseIcon = false;
  bool v_play = true;

  _fetchlesson() async {
    setState(() {
      _loading = true;
      _firsttime = true;
    });
    var res = await ctrl
        .getrequestwithheader('course_lessons/' + widget.id.toString());
    setState(() {
      _loading = false;
      _firsttime = false;
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
      var s = 0;
      if (res['courses'].length != 0) {
        List<dynamic> data = res['courses'];
        for (int i = 0; i < data.length; i++) {
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
            //print('video_url_for_mobile_application');
            //print(data[i]['lessons'][c]['video_url_for_mobile_application'].toString());
            //print(data[i]['lessons'][c]);
            data[i]['lessons'][c]['source_count'] = s.toString();
            _dataSourceList.add(
              BetterPlayerDataSource(
                  BetterPlayerDataSourceType.network,
                  data[i]['lessons'][c]['video_url_for_mobile_application']
                      .toString()),
            );
            _dataSourceListIds.add(data[i]['lessons'][c]['id'].toString());
            s++;
          }
          if (!mounted) return;
          setState(() {
            _lesson.add(Lesson.fromJson(data[i]));
          });
        }
      }
    }
    if (active_lesson_id != '') {
      _fetchlessonnote();
      _fetchtask();
      _fetchqanda();
    } else {
      if (!mounted) return;
      setState(() {
        load_notes = false;
        load_task = false;
        load_qanda = false;
      });
    }
  }

  _fetchlessonnote() async {
    if (!mounted) return;
    setState(() {
      load_notes = true;
    });
    var res = await ctrl.getrequestwithheader('bookmarks/' + active_lesson_id);
    if (!mounted) return;
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

  _fetchqanda() async {
    setState(() {
      load_qanda = true;
    });
    var res = await ctrl.getrequestwithheader('qanda/' + active_lesson_id);
    if (!mounted) return;
    setState(() {
      _qanda.clear();
      load_qanda = false;
    });
    if (res != null && res != 'null' && res.containsKey('data')) {
      List<dynamic> data = res['data'];
      for (int i = 0; i < data.length; i++) {
        //print(data[i]);
        if (!mounted) return;
        setState(() {
          _qanda.add(QandA.fromJson(data[i]));
        });
      }
    }
  }

  _callbackfunc(data) {
    setState(() {
      active_lesson_id = data['lesson_id'];
      _fetchlessonnote();
      _fetchtask();
    });
    _betterPlayerPlaylistController.setupDataSource(data['source_count']);
  }

  _addnotes() async {
    if (_notesctrl.text == '' || _notesctrl.text == null) {
      await ctrl.toastmsg('Enter the notes', 'short');
      return;
    }
    Get.back();
    String cv = _betterPlayerPlaylistController
        .betterPlayerController.videoPlayerController.value.position
        .toString();
    String v = cv.substring(0, cv.indexOf('.'));
    var parts = v.split(':');
    var p = (int.parse(parts[0]) * 3600) +
        (int.parse(parts[1]) * 60) +
        (int.parse(parts[2]));
    Map data = {
      'duration': p.toString(),
      'lessonId': active_lesson_id.toString(),
      'notes': _notesctrl.text
    };
    setState(() {
      load_notes = true;
    });
    var res = await ctrl.requestwithheader(data, 'bookmark/create');
    _fetchlessonnote();
  }

  _sendqanda() async {
    if (_qandactrl.text == '' || _qandactrl.text.length == 0) {
      return;
    }
    setState(() {
      load_qanda = true;
    });
    Map data = {
      'qanda_course_id': widget.id,
      'qanda_lesson_id': active_lesson_id,
      'qanda_question': _qandactrl.text,
      'lesson_qanda_audio': q_voice != '' ? q_voice.toString() : null,
      'lesson_qanda_file': q_gallery != ''
          ? q_gallery.toString()
          : q_camera != ''
              ? q_camera.toString()
              : q_doc != ''
                  ? q_doc.toString()
                  : null,
      'lesson_qanda_audio_extension':
          q_voice != '' ? q_voice_extension.toString() : null,
      'lesson_qanda_file_extension': q_gallery != ''
          ? q_gallery_extension.toString()
          : q_camera != ''
              ? q_camera_extension.toString()
              : q_doc != ''
                  ? q_doc_extension.toString()
                  : null,
    };
    var res = await ctrl.requestwithheader(data, 'save_qanda_answer');
    if (!mounted) return;
    setState(() {
      _qandactrl.text = '';
      q_voice = '';
      q_gallery = '';
      q_camera = '';
      q_doc = '';
    });
    //print(res);
    _fetchqanda();
  }

  _notecallbackfunc(data) async {
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
                  load_notes = true;
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
                              '@ ' + res['duration'] != 'null' &&
                                      res['duration'] != null
                                  ? ctrl
                                      .getTimeString(int.parse(res['duration']))
                                  : '',
                              style: buttonTextStyle()
                                  .copyWith(color: konPrimaryColor1),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                data['note'] = _notesctrl.text;
                                setState(() {
                                  load_notes = true;
                                });
                                Get.back();
                                var res = await ctrl.requestwithheader(
                                    data, 'bookmarks_update_note_by_id');
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
    } else if (data['action_type'] == 'position') {
//      setState(() {
//        active_lesson_id = data['lesson_id'];
//        _fetchlessonnote();
//        _fetchtask();
//      });
//      _betterPlayerPlaylistController.setupDataSource(data['section_index']);
      final now = Duration(seconds: data['duration']);
      Duration duration = Duration(milliseconds: now.inMilliseconds);
      _betterPlayerPlaylistController
          .betterPlayerController.videoPlayerController
          .seekTo(duration);
    }
  }

  _taskcallback(data) async {
    if (data['action_type'] == 'delete') {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(""),
          content: Text(
            "Are you sure you want to delete this task?",
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
                  load_task = true;
                });
                var res = await ctrl.requestwithheader(data, 'tasks_delete');
                _fetchtask();
              },
              child: Text(
                "DELETE",
                style: buttonTextStyle().copyWith(color: konPrimaryColor1),
              ),
            ),
          ],
        ),
      );
    }
  }

  _qandacallback(data) async {
    if (data['action_type'] == 'delete') {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(""),
          content: Text(
            "Are you sure you want to delete this question?",
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
                  load_qanda = true;
                });
                var res = await ctrl.requestwithheader(data, 'qanda_delete');
                _fetchqanda();
              },
              child: Text(
                "DELETE",
                style: buttonTextStyle().copyWith(color: konPrimaryColor1),
              ),
            ),
          ],
        ),
      );
    }
  }

  _fetchtask() async {
    setState(() {
      load_task = true;
    });
    var res = await ctrl.getrequestwithheader('tasks/' + active_lesson_id);
    //print(res);
    setState(() {
      load_task = false;
      _task.clear();
    });
    if (res != null && res != 'null' && res.containsKey('data')) {
      List<dynamic> data = res['data'];
      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        if (!mounted) return;
        setState(() {
          _task.add(Task.fromJson(data[i]));
        });
      }
    }
  }

  _savetask() async {
    Map data = {
      'task_lesson_id': active_lesson_id,
      'task_course_id': widget.id,
      'lesson_task_answer': _taskctrl.text.toString(),
      'lesson_task_audio': t_voice != '' ? t_voice.toString() : null,
      'lesson_task_file': t_gallery != ''
          ? t_gallery.toString()
          : t_camera != ''
          ? t_camera.toString()
          : t_doc != ''
          ? t_doc.toString()
          : null,
      'lesson_task_audio_extension':
      t_voice != '' ? t_voice_extension.toString() : null,
      'lesson_task_file_extension': t_gallery != ''
          ? t_gallery_extension.toString()
          : t_camera != ''
          ? t_camera_extension.toString()
          : t_doc != ''
          ? t_doc_extension.toString()
          : null,
    };
    //print(data);
    var res = await ctrl.requestwithheader(data, 'save_task_answer');
    if (!mounted) return;
    setState(() {
      _taskctrl.text = '';
      t_voice = '';
      t_gallery = '';
      t_camera = '';
      t_doc = '';
    });
    if (res.containsKey('message')) {
      await ctrl.toastmsg(res['message'], 'long');
    }
    _fetchtask();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    //_mRecorderIsInited = true;
  }

  checkpermission () async {
    var storage = await Permission.storage.request();
    var camera = await Permission.camera.request();
    var microphone = await Permission.microphone.request();
    if (storage != PermissionStatus.granted || microphone != PermissionStatus.granted || camera != PermissionStatus.granted) {
      return 'false';
      return;
    }
    return 'true';
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    _betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 1,
      fit: BoxFit.cover,
      placeholderOnTop: true,
      autoPlay: true,
      //looping: true,
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
          enablePip: true,
          forwardSkipTimeInMilliseconds: 10000,
          backwardSkipTimeInMilliseconds: 10000),
      eventListener: (event) async {
        if (_betterPlayerPlaylistController?.currentDataSourceIndex != null) {
          // print(_betterPlayerPlaylistController.currentDataSourceIndex);
          //print(event.betterPlayerEventType);
          //print(BetterPlayerEventType.values);
          //print(event.betterPlayerEventType);
          if (event.betterPlayerEventType ==
              BetterPlayerEventType.setupDataSource) {
            setState(() {
              active_lesson_id = _dataSourceListIds[
                  _betterPlayerPlaylistController.currentDataSourceIndex];
              _fetchlessonnote();
              _fetchtask();
            });
          }
          if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
            setState(() {
              pauseIcon = true;
            });
          }
          if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
            setState(() {
              pauseIcon = false;
            });
            if(v_play){
              setState(() {
                v_play = false;
              });
              Map data = {
                'lessonId': _dataSourceListIds[
                _betterPlayerPlaylistController.currentDataSourceIndex]
                    .toString(),
                'progress': 0.toString()
              };
              print(data);
              var res =
              await ctrl.requestwithheader(data, 'mark_lesson_completed');
              print(res);
              print('first_timeeeeeeeeeeeeeeeee');
            }
          }
          if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
            print(_dataSourceListIds[
                _betterPlayerPlaylistController.currentDataSourceIndex]);
            Map data = {
              'lessonId': _dataSourceListIds[
                      _betterPlayerPlaylistController.currentDataSourceIndex]
                  .toString(),
              'progress': 1.toString()
            };
            print(data);
            var res =
                await ctrl.requestwithheader(data, 'mark_lesson_completed');
            print(res);
          }
        }
      },
    );
    _betterPlayerPlaylistConfiguration = BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 1),
    );
    //_betterPlayerPlaylistController.betterPlayerController.addEventsListener(_handlevideoevent);
    _fetchlesson();
    _fetchqanda();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    _mPlayer.closeAudioSession();
    _mPlayer = null;

    _mRecorder.closeAudioSession();
    _mRecorder = null;
    _betterPlayerPlaylistController?.betterPlayerController?.dispose();
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
            if (_dataSourceList.length == 0) {
              await ctrl.toastmsg('Video not found', 'short');
              return;
            }
            if (_betterPlayerPlaylistController
                .betterPlayerController.videoPlayerController.value.isPlaying) {
              _betterPlayerPlaylistController.betterPlayerController.pause();
              //await ctrl.toastmsg('Pause video and add notes', 'short');
              //return;
            }
            setState(() {
              _notesctrl.text = '';
            });
            showModalBottomSheet(
                isDismissible: false,
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
                                InkWell(
                                    onTap: () {
                                      if (!_betterPlayerPlaylistController
                                          .betterPlayerController
                                          .videoPlayerController
                                          .value
                                          .isPlaying) {
                                        _betterPlayerPlaylistController
                                            .betterPlayerController
                                            .videoPlayerController
                                            .play();
                                      }
                                      Get.back();
                                    },
                                    child: Icon(Icons.close)),
                                Text(
                                  '@ ' +
                                      _betterPlayerPlaylistController
                                          .betterPlayerController
                                          .videoPlayerController
                                          .value
                                          .position
                                          .toString()
                                          .substring(
                                              0,
                                              _betterPlayerPlaylistController
                                                  .betterPlayerController
                                                  .videoPlayerController
                                                  .value
                                                  .position
                                                  .toString()
                                                  .indexOf('.')),
                                  style: buttonTextStyle()
                                      .copyWith(color: konPrimaryColor1),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
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
      case 2:
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () async {
            var s = await checkpermission();
            if(s == 'false'){
              await ctrl.toastmsg('Permission cancelled', 'short');
              return;
            }
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter mystate) {
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
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(Icons.cancel)),
                                  Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      if (_qandactrl.text == '') {
                                        await ctrl.toastmsg(
                                            'Question required', 'short');
                                        return;
                                      }
                                      if (!mounted) return;
                                      mystate(() {
                                        load_qanda = true;
                                      });
                                      if (!mounted) return;
                                      setState(() {
                                        load_qanda = true;
                                      });
                                      Get.back();
                                      _sendqanda();
                                    },
                                    child: Text(
                                      'Upload',
                                      style: smallTextStyle().copyWith(
                                          color: konTextInputBorderActiveColor,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: konLightColor4,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (q_gallery != '') {
                                        await ctrl.toastmsg(
                                            'Remove gallery image', 'long');
                                        return;
                                      }
                                      if (q_doc != '') {
                                        await ctrl.toastmsg(
                                            'Remove doc and capture image',
                                            'long');
                                        return;
                                      }
                                      if (q_camera == '') {
                                        List<Media> res =
                                            await ImagesPicker.openCamera(
                                          pickType: PickType.image,
                                          quality: 0.1,
                                        );
                                        if (res != null) {
                                          print(res[0].path);
                                          File file = File(res[0].path);
                                          var img_path = base64Encode(
                                              file.readAsBytesSync());
                                          var extension =
                                              p.extension(res[0].path);
                                          mystate(() {
                                            q_camera_preview = file.path;
                                            q_camera_extension =
                                                extension.replaceAll('.', '');
                                            q_camera =
                                                'data:image/${extension.replaceAll('.', '')};base64,' +
                                                    img_path;
                                          });
                                        }
                                      } else {
                                        mystate(() {
                                          q_camera = '';
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image(
                                              image: AssetImage(q_camera == ''
                                                  ? camera
                                                  : close)),
                                          SizedBox(height: 5),
                                          Text('Camera'),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (q_camera != '') {
                                        await ctrl.toastmsg(
                                            'Remove image taken from camera',
                                            'long');
                                        return;
                                      }
                                      if (q_doc != '') {
                                        await ctrl.toastmsg(
                                            'Remove doc and add image', 'long');
                                        return;
                                      }
                                      if (q_gallery == '') {
                                        FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                              'jpg',
                                              'png',
                                              'jpeg'
                                            ]);
                                        if (result != null) {
                                          if (result.files.first.extension ==
                                                  'png' ||
                                              result.files.first.extension ==
                                                  'jpeg' ||
                                              result.files.first.extension ==
                                                  'jpg') {
                                            File file =
                                                File(result.files.first.path);
                                            var img_path = base64Encode(
                                                file.readAsBytesSync());
                                            mystate(() {
                                              q_camera_preview = file.path;
                                              q_gallery_extension =
                                                  result.files.first.extension;
                                              q_gallery =
                                                  'data:image/${result.files.first.extension};base64,' +
                                                      img_path;
                                            });
                                          } else {
                                            await ctrl.toastmsg(
                                                'Only png,jpg,jpeg allowed',
                                                'long');
                                            setState(() {
                                              q_gallery = '';
                                            });
                                          }
                                        } else {
                                          print('cancelled');
                                          setState(() {
                                            q_gallery = '';
                                          });
                                        }
                                      } else {
                                        mystate(() {
                                          q_gallery = '';
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image(
                                              image: AssetImage(q_gallery == ''
                                                  ? gallery
                                                  : close)),
                                          SizedBox(height: 5),
                                          Text('Gallery'),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (q_gallery != '') {
                                        await ctrl.toastmsg(
                                            'Remove image and add document',
                                            'long');
                                        return;
                                      }
                                      if (q_camera != '') {
                                        await ctrl.toastmsg(
                                            'Remove image and add document',
                                            'long');
                                        return;
                                      }
                                      if (q_doc == '') {
                                        FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'pdf',
                                                  'docx',
                                                  'doc'
                                            ]);
                                        if (result != null) {
                                          if (result.files.first.extension ==
                                                  'pdf' ||
                                              result.files.first.extension ==
                                                  'docx' ||
                                              result.files.first.extension ==
                                                  'doc') {
                                            File file =
                                                File(result.files.first.path);
                                            var img_path = base64Encode(
                                                file.readAsBytesSync());
                                            mystate(() {
                                              q_doc_preview = file.path;
                                              q_doc_extension =
                                                  result.files.first.extension;
                                              print(q_doc);
                                              q_doc =
                                                  'data:application/${result.files.first.extension};base64,' +
                                                      img_path;
                                            });
                                          } else {
                                            await ctrl.toastmsg(
                                                'Only pdf,docx,doc allowed',
                                                'long');
                                            setState(() {
                                              q_doc = '';
                                            });
                                          }
                                        } else {
                                          print('cancelled');
                                          setState(() {
                                            q_doc = '';
                                          });
                                        }
                                      } else {
                                        mystate(() {
                                          q_doc = '';
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image(
                                              image: AssetImage(q_doc == ''
                                                  ? document
                                                  : close)),
                                          SizedBox(height: 5),
                                          Text('Document'),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  q_voice == ''
                                      ? GestureDetector(
                                          onLongPressStart: (v) {
                                            mystate(() {
                                              recording = true;
                                            });
                                            openTheRecorder().then((value) {
                                              _mRecorder
                                                  .startRecorder(
                                                toFile: _mPath,
                                                audioSource: theSource,
                                              )
                                                  .then((value) {
                                                setState(() {});
                                              });
                                            });
                                          },
                                          onLongPressEnd: (v) async {
                                            mystate(() {
                                              recording = false;
                                            });
                                            await _mRecorder
                                                .stopRecorder()
                                                .then((value) {
                                              _mRecorder
                                                  .getRecordURL(path: _mPath)
                                                  .then((value) {
                                                File file = File(value);
                                                var img_path = base64Encode(
                                                    file.readAsBytesSync());
                                                mystate(() {
                                                  q_voice =
                                                      'data:audio/wav;base64,' +
                                                          img_path.toString();
                                                  q_voice_extension = 'wav';
                                                });
                                                //log(img_path);
                                              });
                                            });
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Image(
                                                    width: 50,
                                                    height: 50,
                                                    image: AssetImage(!recording
                                                        ? record_audio
                                                        : recorder)),
//                                          Image(
//                                              image: AssetImage(q_voice == ''
//                                                  ? record_audio
//                                                  : close)),
                                                SizedBox(height: 5),
                                                Text('Voice'),
                                              ],
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text(""),
                                                content: Text(
                                                  "Are you sure you want to delete this audio?",
                                                  style: button2TextStyle()
                                                      .copyWith(
                                                          color:
                                                              konDarkColorD3),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      "CANCEL",
                                                      style: buttonTextStyle()
                                                          .copyWith(
                                                              color:
                                                                  konPrimaryColor1),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      mystate(() {
                                                        q_voice_extension = '';
                                                        q_voice = '';
                                                      });
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "DELETE",
                                                      style: buttonTextStyle()
                                                          .copyWith(
                                                              color:
                                                                  konPrimaryColor1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Image(image: AssetImage(close)),
//                                          Image(
//                                              image: AssetImage(q_voice == ''
//                                                  ? record_audio
//                                                  : close)),
                                                SizedBox(height: 5),
                                                Text('Voice'),
                                              ],
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            q_camera !='' || q_gallery != ''?Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                              child: Image.file(File(q_camera_preview),fit: BoxFit.cover,
                                width: 100,height: 100,)
                            ):SizedBox(),

                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Write your question here"),
                                controller: _qandactrl,
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
                });
          },
          child: Icon(Icons.add),
        );
      case 3:
//        return FloatingActionButton(
//          backgroundColor: konTextInputBorderActiveColor,
//          onPressed: () async {
//            showModalBottomSheet(
//                context: context,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.vertical(
//                    top: Radius.circular(20),
//                  ),
//                ),
//                isScrollControlled: true,
//                builder: (context) {
//                  return StatefulBuilder(
//                      builder: (BuildContext context, StateSetter mystate) {
//                    return Padding(
//                      padding: EdgeInsets.only(
//                          bottom: MediaQuery.of(context).viewInsets.bottom),
//                      child: Container(
//                        margin:
//                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisSize: MainAxisSize.min,
//                          children: [
//                            Container(
//                              margin: EdgeInsets.symmetric(
//                                  horizontal: 20, vertical: 10),
//                              child: Row(
//                                children: [
//                                  InkWell(
//                                      onTap: () {
//                                        Get.back();
//                                      },
//                                      child: Icon(Icons.cancel)),
//                                  Spacer(),
//                                  task_file == ''
//                                      ? InkWell(
//                                          onTap: () async {
//                                            //var result = await FilePicker.platform.pickFiles(allowedExtensions: ['.pdf'], type: FileType.custom);
//                                            FilePickerResult result =
//                                                await FilePicker.platform
//                                                    .pickFiles(
//                                                        type: FileType.custom,
//                                                        allowedExtensions: [
//                                                  'pdf'
//                                                ]);
//                                            if (result != null) {
//                                              if (result
//                                                      .files.first.extension ==
//                                                  'pdf') {
//                                                File file = File(
//                                                    result.files.first.path);
//                                                var img_path = base64Encode(
//                                                    file.readAsBytesSync());
//                                                mystate(() {
//                                                  task_file =
//                                                      'data:application/pdf;base64,' +
//                                                          img_path;
//                                                });
//                                                //final base64String = file.readAsBytes();
////                                        print(base64.encode(file.bytes).toString());
////                                        print('yesss');
////                                        print(file.name);
////                                        print(file.bytes);
////                                        print(file.size);
////                                        print(file.extension);
////                                        print(file.path.readAsByteSync());
//                                              } else {
//                                                await ctrl.toastmsg(
//                                                    'Only pdf allowed', 'long');
//                                                setState(() {
//                                                  task_file = '';
//                                                });
//                                              }
//                                            } else {
//                                              print('cancelled');
//                                              setState(() {
//                                                task_file = '';
//                                              });
//                                            }
//                                          },
//                                          child: Icon(
//                                            Icons.file_upload,
//                                            color: Colors.green,
//                                          ))
//                                      : InkWell(
//                                          onTap: () async {
//                                            mystate(() {
//                                              task_file = '';
//                                            });
//                                          },
//                                          child: Icon(
//                                            Icons.remove_circle,
//                                            color: Colors.red,
//                                          ),
//                                        ),
//                                  Spacer(),
//                                  InkWell(
//                                    onTap: () async {
//                                      if (_taskctrl.text == '') {
//                                        await ctrl.toastmsg(
//                                            'Answer required', 'short');
//                                        return;
//                                      }
//                                      if (!mounted) return;
//                                      mystate(() {
//                                        load_notes = true;
//                                      });
//                                      if (!mounted) return;
//                                      setState(() {
//                                        load_notes = true;
//                                      });
//                                      Get.back();
//                                      _savetask();
//                                    },
//                                    child: Text(
//                                      'Upload',
//                                      style: smallTextStyle().copyWith(
//                                          color: konTextInputBorderActiveColor,
//                                          fontSize: 16),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            Container(
//                              child: TextFormField(
//                                controller: _taskctrl,
//                                // expands: true,
//                                //autofocus: true,
//                                maxLines: null,
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    );
//                  });
//                });
//          },
//          child: Icon(Icons.add),
//        );
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () async {
            var s = await checkpermission();
            if(s == 'false'){
              await ctrl.toastmsg('Permission cancelled', 'short');
              return;
            }
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter mystate) {
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
                                      InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(Icons.cancel)),
                                      Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          if (_taskctrl.text == '') {
                                            await ctrl.toastmsg(
                                                'Answer required', 'short');
                                            return;
                                          }
                                          if (!mounted) return;
                                          mystate(() {
                                            load_task = true;
                                          });
                                          if (!mounted) return;
                                          setState(() {
                                            load_task = true;
                                          });
                                          Get.back();
                                          _savetask();
                                        },
                                        child: Text(
                                          'Upload',
                                          style: smallTextStyle().copyWith(
                                              color: konTextInputBorderActiveColor,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  color: konLightColor4,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (t_gallery != '') {
                                            await ctrl.toastmsg(
                                                'Remove gallery image', 'long');
                                            return;
                                          }
                                          if (t_doc != '') {
                                            await ctrl.toastmsg(
                                                'Remove doc and capture image',
                                                'long');
                                            return;
                                          }
                                          if (t_camera == '') {
                                            List<Media> res =
                                            await ImagesPicker.openCamera(
                                              pickType: PickType.image,
                                              quality: 0.1,
                                            );
                                            if (res != null) {
                                              print(res[0].path);
                                              File file = File(res[0].path);
                                              var img_path = base64Encode(
                                                  file.readAsBytesSync());
                                              var extension =
                                              p.extension(res[0].path);
                                              mystate(() {
                                                t_camera_preview = file.path;
                                                t_camera_extension =
                                                    extension.replaceAll('.', '');
                                                t_camera =
                                                    'data:image/${extension.replaceAll('.', '')};base64,' +
                                                        img_path;
                                              });
                                            }
                                          } else {
                                            mystate(() {
                                              t_camera = '';
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(t_camera == ''
                                                      ? camera
                                                      : close)),
                                              SizedBox(height: 5),
                                              Text('Camera'),
                                            ],
                                          ),
                                          margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (t_camera != '') {
                                            await ctrl.toastmsg(
                                                'Remove image taken from camera',
                                                'long');
                                            return;
                                          }
                                          if (t_doc != '') {
                                            await ctrl.toastmsg(
                                                'Remove doc and add image', 'long');
                                            return;
                                          }
                                          if (t_gallery == '') {
                                            FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'jpg',
                                                  'png',
                                                  'jpeg'
                                                ]);
                                            if (result != null) {
                                              if (result.files.first.extension ==
                                                  'png' ||
                                                  result.files.first.extension ==
                                                      'jpeg' ||
                                                  result.files.first.extension ==
                                                      'jpg') {
                                                File file =
                                                File(result.files.first.path);
                                                var img_path = base64Encode(
                                                    file.readAsBytesSync());
                                                mystate(() {
                                                  t_camera_preview = file.path;
                                                  t_gallery_extension =
                                                      result.files.first.extension;
                                                  t_gallery =
                                                      'data:image/${result.files.first.extension};base64,' +
                                                          img_path;
                                                });
                                              } else {
                                                await ctrl.toastmsg(
                                                    'Only png,jpg,jpeg allowed',
                                                    'long');
                                                setState(() {
                                                  t_gallery = '';
                                                });
                                              }
                                            } else {
                                              print('cancelled');
                                              setState(() {
                                                t_gallery = '';
                                              });
                                            }
                                          } else {
                                            mystate(() {
                                              t_gallery = '';
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(t_gallery == ''
                                                      ? gallery
                                                      : close)),
                                              SizedBox(height: 5),
                                              Text('Gallery'),
                                            ],
                                          ),
                                          margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (t_gallery != '') {
                                            await ctrl.toastmsg(
                                                'Remove image and add document',
                                                'long');
                                            return;
                                          }
                                          if (t_camera != '') {
                                            await ctrl.toastmsg(
                                                'Remove image and add document',
                                                'long');
                                            return;
                                          }
                                          if (t_doc == '') {
                                            FilePickerResult result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'pdf',
                                                  'docx',
                                                  'doc'
                                                ]);
                                            if (result != null) {
                                              if (result.files.first.extension ==
                                                  'pdf' ||
                                                  result.files.first.extension ==
                                                      'docx' ||
                                                  result.files.first.extension ==
                                                      'doc') {
                                                File file =
                                                File(result.files.first.path);
                                                var img_path = base64Encode(
                                                    file.readAsBytesSync());
                                                mystate(() {
                                                  t_doc_preview = file.path;
                                                  t_doc_extension =
                                                      result.files.first.extension;
                                                  print(t_doc);
                                                  t_doc =
                                                      'data:application/${result.files.first.extension};base64,' +
                                                          img_path;
                                                });
                                              } else {
                                                await ctrl.toastmsg(
                                                    'Only pdf,docx,doc allowed',
                                                    'long');
                                                setState(() {
                                                  t_doc = '';
                                                });
                                              }
                                            } else {
                                              print('cancelled');
                                              setState(() {
                                                t_doc = '';
                                              });
                                            }
                                          } else {
                                            mystate(() {
                                              t_doc = '';
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: AssetImage(t_doc == ''
                                                      ? document
                                                      : close)),
                                              SizedBox(height: 5),
                                              Text('Document'),
                                            ],
                                          ),
                                          margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                        ),
                                      ),
                                      t_voice == ''
                                          ? GestureDetector(
                                        onLongPressStart: (v) {
                                          mystate(() {
                                            recording = true;
                                          });
                                          openTheRecorder().then((value) {
                                            _mRecorder
                                                .startRecorder(
                                              toFile: _mPath,
                                              audioSource: theSource,
                                            )
                                                .then((value) {
                                              setState(() {});
                                            });
                                          });
                                        },
                                        onLongPressEnd: (v) async {
                                          mystate(() {
                                            recording = false;
                                          });
                                          await _mRecorder
                                              .stopRecorder()
                                              .then((value) {
                                            _mRecorder
                                                .getRecordURL(path: _mPath)
                                                .then((value) {
                                              File file = File(value);
                                              var img_path = base64Encode(
                                                  file.readAsBytesSync());
                                              mystate(() {
                                                t_voice =
                                                    'data:audio/wav;base64,' +
                                                        img_path.toString();
                                                t_voice_extension = 'wav';
                                              });
                                              //log(img_path);
                                            });
                                          });
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Image(
                                                  width: 50,
                                                  height: 50,
                                                  image: AssetImage(!recording
                                                      ? record_audio
                                                      : recorder)),
//                                          Image(
//                                              image: AssetImage(t_voice == ''
//                                                  ? record_audio
//                                                  : close)),
                                              SizedBox(height: 5),
                                              Text('Voice'),
                                            ],
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      )
                                          : InkWell(
                                        onTap: () {
                                          return showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text(""),
                                              content: Text(
                                                "Are you sure you want to delete this audio?",
                                                style: button2TextStyle()
                                                    .copyWith(
                                                    color:
                                                    konDarkColorD3),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text(
                                                    "CANCEL",
                                                    style: buttonTextStyle()
                                                        .copyWith(
                                                        color:
                                                        konPrimaryColor1),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    mystate(() {
                                                      t_voice_extension = '';
                                                      t_voice = '';
                                                    });
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "DELETE",
                                                    style: buttonTextStyle()
                                                        .copyWith(
                                                        color:
                                                        konPrimaryColor1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Image(image: AssetImage(close)),
//                                          Image(
//                                              image: AssetImage(t_voice == ''
//                                                  ? record_audio
//                                                  : close)),
                                              SizedBox(height: 5),
                                              Text('Voice'),
                                            ],
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                t_camera !='' || t_gallery != ''?Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                    child: Image.file(File(t_camera_preview),fit: BoxFit.cover,
                                      width: 100,height: 100,)
                                ):SizedBox(),

                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Write your answer here"),
                                    controller: _taskctrl,
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
      color: Colors.white,
      isLoading: _loading,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Get.offNamed('/', arguments: { 'currentTab': 2,'data':'' });
                },
                child: Icon(Icons.arrow_back, color: Colors.black)),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: !_firsttime
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dataSourceList.length != 0
                        ? Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(0),
                                height: 220,
                                child: AspectRatio(
                                  child: BetterPlayerPlaylist(
                                    key: _betterPlayerPlaylistStateKey,
                                    betterPlayerConfiguration:
                                        _betterPlayerConfiguration,
                                    betterPlayerPlaylistConfiguration:
                                        _betterPlayerPlaylistConfiguration,
                                    betterPlayerDataSourceList: _dataSourceList,
                                  ),
                                  aspectRatio: 1,
                                ),
                              ),
                              pauseIcon
                                  ? InkWell(
                                      onTap: () {
                                        _betterPlayerPlaylistController
                                            .betterPlayerController
                                            .videoPlayerController
                                            .play();
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 70),
                                          alignment: Alignment.topCenter,
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: konLightColor2,
                                            size: 80,
                                          )),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 10),
                    _dataSourceList.length != 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                if (_betterPlayerPlaylistController
                                        .betterPlayerController
                                        .isPictureInPictureSupported() ==
                                    true) {
                                  _betterPlayerPlaylistController
                                      .betterPlayerController
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
                                    color: konDarkColorB1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
//                          Duration duration = Duration(milliseconds: 100000);
//                          _betterPlayerPlaylistController
//                              .betterPlayerController.videoPlayerController.seekTo(duration);
                        },
                        child: Text(
                          'By ' + author_name.toString(),
                          style:
                              smallTextStyle().copyWith(color: konDarkColorD3),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
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
                          Text('Task'),
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
                                      return BookMarkDetail(
                                          note: _notes[index],
                                          callbackfunc: _notecallbackfunc,
                                          lesson_id: active_lesson_id);
                                    },
                                  ),
                                )
                              : _notes.length == 0 && !load_notes
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
                                                'Click on + icon to add notes',
                                                style: mediumTextStyle()
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color: konDarkColorD3),
                                              ),
                                            ],
                                          )),
                                    )
                                  : Container(
                                      child: Center(
                                          child:
                                              const CircularProgressIndicator()),
                                    ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _qanda.length != 0 && !load_qanda
                                    ? Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 7),
                                          itemCount: _qanda.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return MessagesWidget(
                                              isAuthor: false,
                                              qanda: _qanda[index],
                                              callbackfunc: _qandacallback,
                                            );
                                          },
                                        ),
                                      )
                                    : _qanda.length == 0 && !load_qanda
                                        ? Container(
                                            height: 200,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image(
                                                    image:
                                                        AssetImage(qanda_empty),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'Be the first to ask a Question',
                                                    style: mediumTextStyle()
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                konDarkColorD3),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            child: Center(
                                                child:
                                                    const CircularProgressIndicator()),
                                          ),
                              ],
                            ),
                          ),
                          _task.length != 0 && !load_task
                              ? Container(
                                  color: Color(0xffF6F5FF),
                                  child: ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 7),
                                    itemCount: _task.length,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                          color: Colors.black.withOpacity(0.3));
                                    },
                                    itemBuilder: (context, index) {
                                      return TaskWidget(
                                        task: _task[index],
                                        callbackfunc: _taskcallback,
                                      );
                                    },
                                  ),
                                )
                              : _task.length == 0 && !load_task
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
                                                'Add task answer here',
                                                style: mediumTextStyle()
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color: konDarkColorD3),
                                              ),
                                            ],
                                          )),
                                    )
                                  : Container(
                                      child: Center(
                                          child:
                                              const CircularProgressIndicator()),
                                    ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          floatingActionButton: _getFABWidget(),
        ),
      ),
    );
  }
}
