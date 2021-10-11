class FoodType {
  final String id;
  final String name;
  final String image;
  final String readyInMinutes;
  final String servings;
  FoodType({
    this.id,
    this.name,
    this.image,
    this.readyInMinutes,
    this.servings,
  });
  factory FoodType.fromJson(Map<String, dynamic> json) {
    return FoodType(
      id: json['id'].toString(),
      name: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
}

class FoodTypeList {
  final List<FoodType> list;
  FoodTypeList({
    this.list,
  });

  factory FoodTypeList.fromJson(List<dynamic> json) {
    return FoodTypeList(
      list: json.map((data) => FoodType.fromJson(data)).toList(),
    );
  }
}
