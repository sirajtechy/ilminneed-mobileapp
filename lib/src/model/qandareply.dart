class QandAReply {
  String id;
  String question_id;
  String instructor_id;
  String answer;
  String attachment_type;
  String attachment_url;
  String audio_attachment;

  QandAReply({this.id, this.question_id, this.instructor_id,this.answer,this.attachment_type,this.attachment_url, this.audio_attachment});

  factory QandAReply.fromJson(Map<String, dynamic> json) {
    return QandAReply(
        id: json['id'],
        question_id: json['question_id'],
        instructor_id: json['instructor_id'],
        answer: json['answer'].toString(),
        attachment_type: json['answer'].toString(),
      attachment_url: json['attachment_url'].toString(),
      audio_attachment: json['audio_attachment'].toString(),
    );
  }

}