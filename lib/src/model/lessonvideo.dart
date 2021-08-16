class LessonVideo {
  final String id;
  final String title;
   String duration;
   String section_id;
   String video_type;
   String video_url;
   String lesson_type;
   String attachment_type;
   String video_url_for_mobile_application;
   String duration_for_mobile_application;
   bool active;
   String source_count;

  LessonVideo({this.id,this.title, this.duration, this.section_id, this.video_type, this.video_url, this.lesson_type, this.attachment_type, this.video_url_for_mobile_application,this.duration_for_mobile_application,this.active,this.source_count});

  factory LessonVideo.fromJson(Map<String, dynamic> json) {
    return LessonVideo(
      id: json['id'].toString(),
      title: json['title'].toString(),
      duration: json['duration'],
      section_id: json['section_id'].toString(),
      video_type: json['video_type'].toString(),
      video_url: json['video_url'].toString(),
      lesson_type: json['lesson_type'].toString(),
      attachment_type: json['attachment_type'],
      video_url_for_mobile_application: json['video_url_for_mobile_application'].toString(),
      duration_for_mobile_application: json['duration_for_mobile_application'].toString(),
        source_count: json['source_count'].toString(),
        active: false
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}