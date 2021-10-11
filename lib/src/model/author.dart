class Author {
  final String? id;
  final String? first_name;
  final String? last_name;
  final String? biography;
  final String? total_course;
  final String? total_students;
  final String? review_count;

  Author(
      {this.id,
      this.first_name,
      this.last_name,
      this.biography,
      this.total_course,
      this.total_students,
      this.review_count});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['instructor_details']['id'].toString(),
      first_name: json['instructor_details']['first_name'],
      last_name: json['instructor_details']['last_name'].toString(),
      biography: json['instructor_details']['biography'].toString(),
      total_course: json['total_course'].toString(),
      total_students: json['total_students'].toString(),
      review_count: json['review_count'].toString(),
    );
  }

}