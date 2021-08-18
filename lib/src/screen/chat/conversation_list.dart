import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class Conversation {
  Conversation({
    this.name,
    this.imageUrl,
    this.count,
    this.lastMessage,
    this.isRead,
    this.time,
  });

  final String name;
  final String imageUrl;
  final String count;
  final String lastMessage;
  final bool isRead;
  final String time;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        count: json["count"] == null ? null : json["count"],
        lastMessage: json["lastMessage"] == null ? null : json["lastMessage"],
        isRead: json["isRead"] == null ? null : json["isRead"],
        time: json["time"] == null ? null : json["time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "count": count == null ? null : count,
        "lastMessage": lastMessage == null ? null : lastMessage,
        "isRead": isRead == null ? null : isRead,
        "time": time == null ? null : time,
      };
}

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conversation> conversationList = [
      Conversation(
          name: 'Liam Davies',
          count: "5",
          imageUrl: "https://randomuser.me/api/portraits/med/men/26.jpg",
          time: "4.15 PM",
          isRead: true,
          lastMessage: "Nice pic"),
      Conversation(
          name: 'Sara Anderson',
          count: "5",
          imageUrl: "https://randomuser.me/api/portraits/women/58.jpg",
          time: "4.15 AM",
          isRead: false,
          lastMessage: "Handsome pic!!!"),
      Conversation(
          name: 'Roberto Vega',
          count: "1",
          imageUrl: "https://randomuser.me/api/portraits/med/men/25.jpg",
          time: "4.23 AM",
          isRead: false,
          lastMessage: "10785 berlin"),
      Conversation(
          name: 'Rudi Droste',
          count: "3",
          imageUrl: "https://randomuser.me/api/portraits/med/men/83.jpg",
          time: "5.15 AM",
          isRead: true,
          lastMessage: "Cooling off in the fountain white and black short"),
      Conversation(
          name: 'Kent Brewer',
          count: "3",
          imageUrl: "https://randomuser.me/api/portraits/med/men/52.jpg",
          time: "9.15 AM",
          isRead: true,
          lastMessage: "Winter sunsets brown and black dog sitting near be"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Messages',
          style: ctaTextStyle().copyWith(color: konDarkColorB1, fontSize: 18),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(conversationList[index].imageUrl),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversationList[index].name,
                              style: ctaTextStyle().copyWith(color: konDarkColorB1, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              conversationList[index].lastMessage ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: mediumTextStyle().copyWith(color: konDarkColorD3),
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
                              conversationList[index].count,
                              style: mediumTextStyle()
                                  .copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: konPrimaryColor2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6, right: 3),
                                child: Icon(
                                  Icons.done_all_outlined,
                                  size: 15,
                                  color: konPrimaryColor2,
                                ),
                              ),
                              Text(
                                conversationList[index].time,
                                style: mediumTextStyle().copyWith(color: Color(0xff7A7A7A)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(padding: const EdgeInsets.only(left: 55), child: Divider(thickness: 1));
            },
            itemCount: conversationList.length),
      ),
    );
  }
}
