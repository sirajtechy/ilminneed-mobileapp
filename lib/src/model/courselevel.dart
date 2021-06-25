class Courselevel {
  final String id;
  final String name;

  Courselevel({this.id, this.name});

  factory Courselevel.fromJson(Map<String, dynamic> json) {
    return Courselevel(
      id: json['id'],
      name: json['name'],
    );
  }

}

class CourselevelList {
  List<Courselevel> _list;

  List<Courselevel> get list => _list;

  CourselevelList() {
    _list = [
      new Courselevel(id: 'beginner',name: 'Beginner'),
      new Courselevel(id: 'intermediate',name: 'Intermediate'),
      new Courselevel(id: 'advanced',name: 'Advanced'),
    ];
  }
}