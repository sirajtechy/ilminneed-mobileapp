class Course {
  final String id;
  final String title;
  final String short_description;
  final String language;
  final String price;
  final String discounted_price;
  final String thumbnail;
  final String instructor_name;
  final String level;

  Course({this.id, this.title, this.short_description, this.language, this.price, this.discounted_price, this.thumbnail, this.instructor_name, this.level});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        title: json['title'],
        short_description: json['short_description'],
        language: json['language'],
        price: json['price'].toString(),
        discounted_price: json['discounted_price'].toString(),
        thumbnail: json['thumbnail'],
        instructor_name: json['instructor_name'].toString(),
        level: json['level'],
    );
  }

}