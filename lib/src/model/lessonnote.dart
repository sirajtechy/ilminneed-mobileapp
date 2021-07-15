import 'package:ilminneed/src/model/notes.dart';

class LessonNote {
  String course_id;
  String user_id;
  String instructor_name;
  String title;
  List<Notes> notes;

  LessonNote({this.course_id, this.user_id, this.instructor_name,this.title,this.notes});

  factory LessonNote.fromJson(Map<String, dynamic> json) {
    return LessonNote(
        course_id: json['id'],
        user_id: json['title'],
        instructor_name: json['instructor_name'],
        title: json['title'].toString(),
        notes: json['notes'] != null ? (json['notes'] as List).map((i) => Notes.fromJson(i)).toList() : null,
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}