import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/screen/chat/messages.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class ChatMessage {
  ChatMessage(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.image,
      this.time,
      this.message});

  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? image, time, message;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        image: json["image"] == null ? null : json["image"],
        time: json["time"] == null ? null : json["time"],
        message: json["message"] == null ? "" : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image": image == null ? null : image,
      };
}

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({Key? key}) : super(key: key);

  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<ChatMessage> _chatMessage = [];
  bool _isLoading = true, _isLogin = false;

  _fetchMessageList() async {
    var res = await ctrl.getrequestwithheader('user_chat_messages');
    setState(() {
      _isLoading = false;
    });
    if (res != null) {
      setState(() {
        _chatMessage.clear();
      });
      List<dynamic> data = res;
      debugPrint('the res is $res');
      List.from(data).forEach((element) {
        _chatMessage.add(ChatMessage.fromJson(element));
      });
      setState(() {});
    }
  }

  checkifloggedin() async {
    if (await ctrl.LoggedIn() == true) {
      setState(() {
        _isLogin = true;
      });
      _fetchMessageList();
    }
  }

  @override
  void initState() {
    checkifloggedin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Messages',
          style: ctaTextStyle().copyWith(color: konDarkColorB1, fontSize: 18),
        ),
      ),
      body: _isLogin
          ? _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            await Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ChatMessagesScreen(
                                id: _chatMessage[index].id,
                                name:
                                    '${_chatMessage[index].firstName} ${_chatMessage[index].lastName}',
                                imageUrl: _chatMessage[index].image,
                              );
                            })).then((value) {
                              debugPrint('the value is $value');
                              if (value) {
                                _fetchMessageList();
                              }
                            });
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(_chatMessage[index].image!),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_chatMessage[index].firstName} ${_chatMessage[index].lastName}',
                                          style: ctaTextStyle().copyWith(
                                              color: konDarkColorB1,
                                              fontSize: 14),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          _chatMessage[index].message ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: mediumTextStyle()
                                              .copyWith(color: konDarkColorD3),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          '${index + 1}',
                                          style: mediumTextStyle().copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: konPrimaryColor2),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6, right: 3),
                                            child: Icon(
                                              Icons.done_all_outlined,
                                              size: 15,
                                              color: konPrimaryColor2,
                                            ),
                                          ),
                                          Text(
                                            _chatMessage[index].time ?? "",
                                            style: mediumTextStyle().copyWith(
                                                color: Color(0xff7A7A7A)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Divider(thickness: 1));
                      },
                      itemCount:
                          _chatMessage == null ? 0 : _chatMessage.length),
                )
          : Center(
              child: Text("Please Login ... "),
            ),
    );
  }
}
