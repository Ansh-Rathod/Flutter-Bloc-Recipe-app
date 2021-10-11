class Equipment {
  int? id;
  String? name;
  String? localizedName;
  String? image;

  Equipment({this.id, this.name, this.localizedName, this.image});

  factory Equipment.fromJson(json) => Equipment(
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

class EquipmentsList {
  final List<Equipment> items;
  EquipmentsList({
    required this.items,
  });
  factory EquipmentsList.fromJson(List<dynamic> list) {
    return EquipmentsList(
      items: list.map((data) => Equipment.fromJson(data)).toList(),
    );
  }
}
