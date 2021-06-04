class Equipments {
  final String name;
  final String image;
  Equipments({
    this.name,
    this.image,
  });

  factory Equipments.fromJson(Map<String, dynamic> json) {
    return Equipments(
      image: "https://spoonacular.com/cdn/equipment_100x100/${json['image']}",
      name: json['name'],
    );
  }
}

class EquipmentsList {
  final List<Equipments> items;
  EquipmentsList({
    this.items,
  });
  factory EquipmentsList.fromJson(List<dynamic> list) {
    return new EquipmentsList(
      items: list.map((data) => Equipments.fromJson(data)).toList(),
    );
  }
}
