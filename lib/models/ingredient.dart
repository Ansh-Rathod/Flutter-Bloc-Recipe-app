class Ingredient {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  Ingredient({this.id, this.name, this.localizedName, this.image});

  factory Ingredient.fromJson(json) => Ingredient(
        id: json['id'] as int?,
        name: json['name'] as String?,
        localizedName: json['localizedName'] as String?,
        image: json['image'] as String?,
      );

  toJson() => {
        'id': id,
        'name': name,
        'localizedName': localizedName,
        'image': image,
      };
}
