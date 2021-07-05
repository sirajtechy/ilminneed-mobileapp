class PriceList {
  final String id;
  final String name;

  PriceList({this.id, this.name});

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      id: json['id'],
      name: json['name'],
    );
  }

}

class PriceLists {
  List<PriceList> _list;

  List<PriceList> get list => _list;

  PriceLists() {
    _list = [
      new PriceList(id: 'free',name: 'Free'),
      new PriceList(id: 'paid',name: 'Paid')
    ];
  }
}