import 'package:ilminneed/src/model/qandareply.dart';

class QandA {
  String id;
  String user_id;
  String course_id;
  String question;
  String attachment_type;
  String attachment_url;
  String audio_attachment;
  List<QandAReply> reply;

  QandA({this.id, this.user_id, this.course_id,this.question,this.attachment_type,this.attachment_url,this.audio_attachment, this.reply});

  factory QandA.fromJson(Map<String, dynamic> json) {
    return QandA(
        id: json['id'],
        user_id: json['user_id'],
        course_id: json['course_id'],
        question: json['question'],
        attachment_type: json['attachment_type'].toString(),
        attachment_url: json['attachment_url'].toString(),
        audio_attachment: json['audio_attachment'].toString(),
        reply: json['answer'] != null && json['answer'] != 'null' ? (json['answer'] as List).map((i) => QandAReply.fromJson(i)).toList() : null,
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}