class Review {
  final String id;
  final String rating;
  final String ratable_id;
  final String date_added;
  final String review;
  final String uid;
  final String first_name;
  final String last_name;
  final String role_id;

  Review({this.id, this.rating, this.ratable_id, this.date_added, this.review, this.uid, this.first_name, this.last_name, this.role_id});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'].toString(),
        rating: json['rating'],
        ratable_id: json['ratable_id'].toString(),
        date_added: json['date_added'].toString(),
        review: json['review'].toString(),
        uid: json['uid'].toString(),
        first_name: json['first_name'].toString(),
        last_name: json['last_name'].toString(),
        role_id: json['role_id'].toString(),
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }

}