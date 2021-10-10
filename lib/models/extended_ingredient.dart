import 'measures.dart';

class ExtendedIngredient {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalString;
  String? originalName;
  double? amount;
  String? unit;
  List<dynamic>? meta;
  List<dynamic>? metaInformation;
  Measures? measures;

  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalString,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.metaInformation,
    this.measures,
  });

  factory ExtendedIngredient.fromJson(json) {
    return ExtendedIngredient(
      id: json['id'] as int?,
      aisle: json['aisle'] as String?,
      image: json['image'] as String?,
      consistency: json['consistency'] as String?,
      name: json['name'] as String?,
      nameClean: json['nameClean'] as String?,
      original: json['original'] as String?,
      originalString: json['originalString'] as String?,
      originalName: json['originalName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      meta: json['meta'] as List<dynamic>?,
      metaInformation: json['metaInformation'] as List<dynamic>?,
      measures:
          json['measures'] == null ? null : Measures.fromJson(json['measures']),
    );
  }

  toJson() => {
        'id': id,
        'aisle': aisle,
        'image': image,
        'consistency': consistency,
        'name': name,
        'nameClean': nameClean,
        'original': original,
        'originalString': originalString,
        'originalName': originalName,
        'amount': amount,
        'unit': unit,
        'meta': meta,
        'metaInformation': metaInformation,
        'measures': measures?.toJson(),
      };
}
