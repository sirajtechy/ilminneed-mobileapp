import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/qandareply.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/qandareplywidget.dart';
import 'package:images_picker/images_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

const theSource = AudioSource.microphone;

class QandAReplyScreen extends StatefulWidget {
  final Map? data;

  const QandAReplyScreen({Key? key, this.data}) : super(key: key);

  @override
  _QandAReplyScreenState createState() => _QandAReplyScreenState();
}

class _QandAReplyScreenState extends State<QandAReplyScreen> {
  bool _loading = true;
  final TextEditingController _qandactrl = TextEditingController();
  String q_camera = '';
  String q_camera_extension = '';
  String q_camera_preview = '';
  String q_gallery = '';
  String? q_gallery_extension = '';
  String q_gallery_preview = '';
  String q_doc = '';
  String? q_doc_extension = '';
  String q_voice = '';
  String q_voice_extension = '';
  FlutterSound flutterSound = new FlutterSound();
  bool recording = false;
  String reply_count = '';
  bool load_qanda = true;

  //recording
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  final String _mPath = 'ilminneed_voice_record.wav';

  //recording
  List<QandAReply>? _reply;

  _sendqanda() async {
    if (_qandactrl.text == '' || _qandactrl.text.length == 0) {
      return;
    }
    Map data = {
      'question_id': widget.data!['question_id'],
      'user_id': await ctrl.getuserid(),
      'answer': _qandactrl.text,
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
    var res = await ctrl.requestwithheader(data, 'save_reply_qanda_answer');
    if (!mounted) return;
    setState(() {
      _qandactrl.text = '';
      q_voice = '';
      q_gallery = '';
      q_camera = '';
      q_doc = '';
    });
    print(res);
    _fetchreply();
  }

  _fetchreply() async {
    setState(() {
      load_qanda = true;
    });
    var res = await ctrl
        .getrequestwithheader('qanda_reply/' + widget.data!['question_id']);
    if (!mounted) return;
    setState(() {
      _reply?.clear();
      load_qanda = false;
      _loading = false;
    });
    if (res != null && res != 'null' && res.containsKey('data')) {
      List<dynamic> data = res['data'];
      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        if (!mounted) return;
        setState(() {
          _reply?.add(QandAReply.fromJson(data[i]));
        });
      }
    }
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    //_mRecorderIsInited = true;
  }

  @override
  void dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;
    _mRecorder!.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(widget.data!['question_id']);
    _fetchreply();
  }

  checkpermission() async {
    var storage = await Permission.storage.request();
    var camera = await Permission.camera.request();
    var microphone = await Permission.microphone.request();
    if (storage != PermissionStatus.granted ||
        microphone != PermissionStatus.granted ||
        camera != PermissionStatus.granted) {
      return 'false';
      return;
    }
    return 'true';
  }

  _getFABWidget() {
    if (widget.data!['is_owner'] == 'true') {
      switch (0) {
        case 0:
          return FloatingActionButton(
            backgroundColor: konTextInputBorderActiveColor,
            onPressed: () async {
              var s = await checkpermission();
              if (s == 'false') {
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
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
                                              'Reply text is required',
                                              'short');
                                          return;
                                        }
                                        if (!mounted) return;
                                        mystate(() {
                                          _loading = true;
                                        });
                                        if (!mounted) return;
                                        setState(() {
                                          _loading = true;
                                        });
                                        Get.back();
                                        _sendqanda();
                                      },
                                      child: Text(
                                        'Upload',
                                        style: smallTextStyle().copyWith(
                                            color:
                                                konTextInputBorderActiveColor,
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
                                          List<Media>? res =
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                              'Remove doc and add image',
                                              'long');
                                          return;
                                        }
                                        if (q_gallery == '') {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
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
                                              File file = File(
                                                  result.files.first.path!);
                                              var img_path = base64Encode(
                                                  file.readAsBytesSync());
                                              mystate(() {
                                                q_camera_preview = file.path;
                                                q_gallery_extension = result
                                                    .files.first.extension;
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
                                                image: AssetImage(
                                                    q_gallery == ''
                                                        ? gallery
                                                        : close)),
                                            SizedBox(height: 5),
                                            Text('Gallery'),
                                          ],
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
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
                                              File file = File(
                                                  result.files.first.path!);
                                              var img_path = base64Encode(
                                                  file.readAsBytesSync());
                                              mystate(() {
                                                q_doc_extension = result
                                                    .files.first.extension;
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ),
                                    q_voice == ''
                                        ? GestureDetector(
                                            onLongPressStart: (v) {
                                              mystate(() {
                                                recording = true;
                                              });
                                              openTheRecorder().then((value) {
                                                _mRecorder!
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
                                              await _mRecorder!
                                                  .stopRecorder()
                                                  .then((value) {
                                                _mRecorder!
                                                    .getRecordURL(path: _mPath)
                                                    .then((value) {
                                                  File file = File(value!);
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
                                                      image: AssetImage(
                                                          !recording
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
                                            onTap: () => showDialog(
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
                                            ),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Image(
                                                      image: AssetImage(close)),
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
                              q_camera != '' || q_gallery != ''
                                  ? Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 15),
                                      child: Image.file(
                                        File(q_camera_preview),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ))
                                  : SizedBox(),
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Write your reply text here"),
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
            child: Icon(Icons.reply),
          );
        default:
          return SizedBox();
      }
    }
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
        title: !load_qanda
            ? Text(_reply!.length.toString() + ' Replies',
                style: TextStyle(color: konBlackColor))
            : Text('Replies', style: TextStyle(color: konBlackColor)),
      ),
      body: LoadingOverlay(
        color: Colors.white,
        isLoading: _loading,
        child: Container(
          child: SingleChildScrollView(
            child: _reply?.length != 0 && !load_qanda
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _reply?.length ?? 0,
                          separatorBuilder: (context, index) {
                            return Divider(color: Colors.grey);
                          },
                          itemBuilder: (context, index) {
                            return QandAReplyWidget(answer: _reply?[index]);
                          },
                        ),
                      )
                    ],
                  )
                : _reply?.length == 0 && !load_qanda
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
                                  'No replies found',
                                  style: mediumTextStyle().copyWith(
                                      fontSize: 15, color: konDarkColorD3),
                                ),
                              ],
                            )),
                      )
                    : Container(),
          ),
        ),
      ),
      floatingActionButton: _getFABWidget(),
    );
  }
}
