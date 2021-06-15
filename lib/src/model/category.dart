class CategoryModel {
  final String id;
  final String code;
  final String name;
  final String parent;
  final String slug;
  final String thumbnail;
  final String number_of_courses;

  CategoryModel({this.id, this.code, this.name, this.parent, this.slug, this.number_of_courses, this.thumbnail});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      parent: json['parent'],
      slug: json['slug'],
      number_of_courses: json['number_of_courses'].toString(),
      thumbnail: json['thumbnail']
    );
  }

}