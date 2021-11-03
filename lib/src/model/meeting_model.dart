class MeetingModel {
  final String? id;
  final String? user_id;
  final String? name;
  final String? sdate;
  final String? stime;
  final String? edate;
  final String? etime;
  final String? course;
  final String? link;
  final String? apassword;
  final String? status;

  MeetingModel(
      {this.id,
      this.user_id,
      this.name,
      this.sdate,
      this.stime,
      this.edate,
      this.etime,
      this.course,
      this.link,
      this.apassword,
      this.status});

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
        id: json['id'].toString(),
        user_id: json['user_id'].toString(),
        name: json['name'],
        sdate: json['sdate'],
        stime: json['stime'],
        edate: json['edate'],
      etime: json['etime'],
      course: json['course'],
      link: json['link'],
      apassword: json['apassword'],
      status: json['status']
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}