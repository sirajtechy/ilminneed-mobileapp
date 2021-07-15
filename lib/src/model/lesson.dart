import 'package:ilminneed/src/model/lessonvideo.dart';

class Lesson {
   String id;
   String title;
   String course_id;
  List<LessonVideo> lesson_video;
   bool active;

  Lesson({this.id, this.title, this.course_id, this.lesson_video,this.active});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json['id'],
        title: json['title'],
        course_id: json['course_id'],
        lesson_video: json['lessons'] != null ? (json['lessons'] as List).map((i) => LessonVideo.fromJson(i)).toList() : null,
        active: false
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}