class SearchResult {
  final String id;
  final String name;
  final String image;
  SearchResult({
    required this.id,
    required this.name,
    required this.image,
  });
  factory SearchResult.fromJson(json) {
    return SearchResult(
      id: json['id'].toString(),
      name: json['title'],
      image: json['image'],
    );
  }
}

class SearchResultList {
  final List<SearchResult> list;
  SearchResultList({
    required this.list,
  });

  factory SearchResultList.fromJson(List<dynamic> json) {
    return SearchResultList(
      list: json.map((data) => SearchResult.fromJson(data)).toList(),
    );
  }
}
