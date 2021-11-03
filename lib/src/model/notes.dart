class Notes {
  final String? id;
  final String? duration;
  final String? note;

  Notes({this.id, this.duration, this.note});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'].toString(),
      duration: json['duration'].toString(),
      note: json['note'],
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}