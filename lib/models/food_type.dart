class FoodType {
  final String id;
  final String name;
  final String image;
  final String readyInMinutes;
  final String servings;
  FoodType({
    required this.id,
    required this.name,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
  });
  factory FoodType.fromJson(json) {
    return FoodType(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      image: json['image'] ?? '',
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
}

class FoodTypeList {
  final List<FoodType> list;
  FoodTypeList({
    required this.list,
  });

  factory FoodTypeList.fromJson(List<dynamic> json) {
    return FoodTypeList(
      list: json.map((data) => FoodType.fromJson(data)).toList(),
    );
  }
}
