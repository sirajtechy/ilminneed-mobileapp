class SearchHistory {
  final String id;
  final String term;

  SearchHistory({this.id, this.term});

  factory SearchHistory.fromJson(Map<String, dynamic> json) {
    return SearchHistory(
        id: json['id'],
        term: json['term'],
    );
  }

}