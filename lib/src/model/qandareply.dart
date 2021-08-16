class QandAReply {
  String id;
  String question_id;
  String instructor_id;
  String user_id;
  String is_instructor;
  String first_name;
  String last_name;
  String answer;
  String attachment_type;
  String attachment_url;
  String audio_attachment;

  QandAReply({this.id, this.question_id, this.instructor_id,this.answer,this.attachment_type,this.attachment_url, this.audio_attachment,this.user_id,this.first_name,this.last_name,this.is_instructor});

  factory QandAReply.fromJson(Map<String, dynamic> json) {
    return QandAReply(
        id: json['id'],
        question_id: json['question_id'],
        instructor_id: json['instructor_id'],
        answer: json['answer'].toString(),
      is_instructor: json['is_instructor'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
        attachment_type: json['attachment_type'].toString(),
      attachment_url: json['attachment_url'].toString(),
      audio_attachment: json['audio_attachment'].toString(),
    );
  }

}