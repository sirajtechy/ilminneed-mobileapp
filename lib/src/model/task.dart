class Task {
  final String? id;
  final String? user_id;
  final String? instructor_id;
  final String? course_id;
  final String? lesson_id;
  final String? answer;
  final String? attachment_type;
  final String? attachment_url;
  final String? audio_attachment;
  final String? status;
  final String? date_added;
  final String? date_modified;

  Task(
      {this.id,
      this.user_id,
      this.instructor_id,
      this.course_id,
      this.lesson_id,
      this.answer,
      this.attachment_type,
      this.attachment_url,
      this.audio_attachment,
      this.status,
      this.date_added,
      this.date_modified});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      user_id: json['user_id'].toString(),
      instructor_id: json['instructor_id'],
      course_id: json['course_id'],
      lesson_id: json['lesson_id'],
      answer: json['answer'],
      attachment_type: json['attachment_type'],
      attachment_url: json['attachment_url'],
      audio_attachment: json['audio_attachment'],
      status: json['status'],
      date_added: json['date_added'],
      date_modified: json['date_modified'],
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}