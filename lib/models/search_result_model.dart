class SearchResult {
  final String id;
  final String name;
  final String image;
  SearchResult({
    this.id,
    this.name,
    this.image,
  });
  factory SearchResult.fromJson(Map<String, dynamic> json) {
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
    this.list,
  });

  factory SearchResultList.fromJson(List<dynamic> json) {
    return SearchResultList(
      list: json.map((data) => SearchResult.fromJson(data)).toList(),
    );
  }
}
