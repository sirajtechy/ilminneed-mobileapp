class Course {
  final String id;
  final String user_id;
  final String title;
  final String short_description;
  final String language;
  final String price;
  final String discounted_price;
  final String thumbnail;
  final String instructor_name;
  final String level;
  final String last_edited;
  final String date_created;
  final String video_url;
  final String rating;
  final String discount_flag;
  final String total_lessons;
  final String total_number_of_quizzes;
  final String is_certificate;
  final String number_of_ratings;
  final String course_duration;
  final String is_carted;
  final String is_wishlisted;
  final String course_total_reviews;

  Course({this.id, this.title, this.short_description, this.language, this.price, this.discounted_price, this.thumbnail, this.instructor_name, this.level, this.last_edited,this.date_created,this.video_url, this.rating,this.discount_flag, this.total_lessons, this.total_number_of_quizzes, this.is_certificate, this.number_of_ratings, this.user_id, this.course_duration, this.is_carted, this.is_wishlisted,this.course_total_reviews});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        title: json['title'],
        short_description: json['short_description'],
        language: json['language'],
        price: json['price'].toString(),
        discounted_price: json['discounted_price'].toString(),
        thumbnail: json['thumbnail'].toString(),
        instructor_name: json['instructor_name'].toString(),
        level: json['level'],
        last_edited: json['last_edited'].toString(),
        date_created: json['date_created'].toString(),
        video_url: json['video_url'].toString(),
        rating: json['rating'].toString(),
        discount_flag: json['discount_flag'].toString(),
        total_lessons: json['total_number_of_lessons'].toString(),
        total_number_of_quizzes: json['total_number_of_quizzes'].toString(),
        number_of_ratings: json['number_of_ratings'].toString(),
        is_certificate: json['is_certificate'].toString(),
        user_id: json['user_id'].toString(),
        course_duration: json['course_duration'].toString(),
        is_carted: json['is_carted'].toString(),
        is_wishlisted: json['is_wishlisted'].toString(),
        course_total_reviews: json['course_total_reviews'].toString()
    );
    //json.containsKey('sections')?json['sections'].length != 0?json['sections'][0]['lessons'].length.toString():'0':'0'
  }



}