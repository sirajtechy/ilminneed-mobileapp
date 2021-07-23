import 'package:ilminneed/src/model/notes.dart';

class LessonNote {
  String course_id;
  String user_id;
  String instructor_name;
  String title;
  String lesson_id;
  List<Notes> notes;

  LessonNote({this.course_id, this.user_id, this.instructor_name,this.title,this.notes,this.lesson_id});

  factory LessonNote.fromJson(Map<String, dynamic> json) {
    return LessonNote(
        course_id: json['id'],
        user_id: json['title'],
        instructor_name: json['instructor_name'],
        title: json['title'].toString(),
        lesson_id: json['lesson_id'].toString(),
        notes: json['notes'] != null ? (json['notes'] as List).map((i) => Notes.fromJson(i)).toList() : null,
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}