import 'package:flutter/material.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class Message {
  Message({
    this.id,
    this.sender,
    this.receiver,
    this.isUser,
    this.message,
    this.time,
  });

  final String id;
  final String sender;
  final String receiver;
  final bool isUser;
  final String message;
  final String time;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        sender: json["sender"] == null ? null : json["sender"],
        receiver: json["receiver"] == null ? null : json["receiver"],
        isUser: json["is_user"] == null ? null : json["is_user"],
        message: json["message"] == null ? null : json["message"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sender": sender == null ? null : sender,
        "receiver": receiver == null ? null : receiver,
        "is_user": isUser == null ? null : isUser,
        "message": message == null ? null : message,
        "time": time == null ? null : time,
      };
}

class ChatMessagesScreen extends StatefulWidget {
  final String id, imageUrl, name;

  const ChatMessagesScreen({Key key, @required this.id, @required this.imageUrl, @required this.name})
      : super(key: key);

  @override
  _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  List<Message> _messages = [];
  bool _isLoading = true;
  final FocusNode focusNode = new FocusNode();

  final TextEditingController chatController = new TextEditingController();

  _fetchMessageList() async {
    final String moduleName = "user_instructor_chat_message/${widget.id}";
    var res = await ctrl.getrequestwithheader(moduleName);
    setState(() {
      _isLoading = false;
    });
    if (res != null) {
      setState(() {
        _messages.clear();
      });
      List<dynamic> data = res;
      List.from(data).forEach((element) {
        _messages.add(Message.fromJson(element));
      });
      setState(() {});
    }
  }

  _sendMessage() async {
    final String value = chatController.text;
    chatController.clear();
    focusNode.unfocus();
    final Message tempMessage = Message(message: value, isUser: true);
    setState(() {
      _messages.add(tempMessage);
    });
    var res = await ctrl.requestwithheader({'message_receiver_id': widget.id, "message": value}, 'chat_message_send');
    Future.delayed(Duration.zero, () => _fetchMessageList());
  }

  @override
  void initState() {
    _fetchMessageList();
    super.initState();
  }

  @override
  void dispose() {
    chatController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.name,
              style: ctaTextStyle().copyWith(color: konDarkColorB1, fontSize: 18),
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: _messages != null ? _messages.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final bool _isUser = _messages[index].isUser;
                        debugPrint('the is user is $_isUser');
                        return Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: _isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(_messages[index].message,
                                    style: mediumTextStyle().copyWith(color: konDarkColorB1, fontSize: 14)),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xffF0F1FF),
                                  borderRadius: !_isUser
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(18),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        )
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        ),
                                ),
                              ),
                              Text(
                                _messages[index].time ?? "",
                                style: mediumTextStyle().copyWith(color: konDarkColorB1, fontSize: 12),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 10, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(color: Color(0xffF0F1FF), borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: chatController,
                              focusNode: focusNode,
                              style: mediumTextStyle().copyWith(color: konDarkColorB1, fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'Send Message'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0, top: 4),
                          child: GestureDetector(
                            onTap: () => _sendMessage(),
                            child: CircleAvatar(
                              backgroundColor: konPrimaryColor2,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
