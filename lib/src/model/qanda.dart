import 'package:ilminneed/src/model/qandareply.dart';

class QandA {
  String id;
  String user_id;
  String course_id;
  String first_name;
  String last_name;
  String question;
  String attachment_type;
  String attachment_url;
  String audio_attachment;
  List<QandAReply> reply;
  String reply_count;
  String is_owner;

  QandA({this.id, this.user_id, this.course_id,this.question,this.attachment_type,this.attachment_url,this.audio_attachment, this.reply,this.reply_count,this.last_name,this.first_name,this.is_owner});

  factory QandA.fromJson(Map<String, dynamic> json) {
    return QandA(
        id: json['id'],
        user_id: json['user_id'],
        course_id: json['course_id'],
        question: json['question'],
        attachment_type: json['attachment_type'].toString(),
        attachment_url: json['attachment_url'].toString(),
        audio_attachment: json['audio_attachment'].toString(),
        //reply: json['answer'] != null && json['answer'] != 'null' ? (json['answer'] as List).map((i) => QandAReply.fromJson(i)).toList() : null,
      reply_count: json['answer'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
      is_owner: json['is_owner'].toString(),
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}