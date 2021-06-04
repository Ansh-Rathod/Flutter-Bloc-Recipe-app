class SearchAutoComplete {
  final String id;
  final String name;
  final String image;
  SearchAutoComplete({
    this.id,
    this.name,
    this.image,
  });
  factory SearchAutoComplete.fromJson(Map<String, dynamic> json) {
    return SearchAutoComplete(
      id: json['id'].toString(),
      name: json['title'],
      image:
          "https://spoonacular.com/recipeImages/${json['id']}-556x370.${json['imageType']}",
    );
  }
}

class SearchAutoCompleteList {
  final List<SearchAutoComplete> list;
  SearchAutoCompleteList({
    this.list,
  });

  factory SearchAutoCompleteList.fromJson(List<dynamic> json) {
    return SearchAutoCompleteList(
      list: json.map((data) => SearchAutoComplete.fromJson(data)).toList(),
    );
  }
}
