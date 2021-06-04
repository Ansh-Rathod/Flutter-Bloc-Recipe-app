class ExtendedIngredients {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalString;
  final String originalName;
  final double amount;
  final String unit;
  final List meta;
  final List metaInformation;
  Measures measures;

  ExtendedIngredients(
      {this.id,
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
      this.measures});

  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredients(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalString: json['originalString'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: json['meta'],
      metaInformation: json['metaInformation'],
      measures: Measures.fromJson(json['measures']),
    );
  }
}

class Measures {
  Us us;
  Metric metric;

  Measures({this.us, this.metric});

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      us: Us.fromJson(json['us']),
      metric: Metric.fromJson(json['metric']),
    );
  }
}

class Us {
  final double amount;
  final String unitShort;
  final String unitLong;

  Us({this.amount, this.unitShort, this.unitLong});

  factory Us.fromJson(Map<String, dynamic> json) {
    return Us(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}

class Metric {
  final double amount;
  final String unitShort;
  final String unitLong;

  Metric({this.amount, this.unitShort, this.unitLong});

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      amount: json['amount'],
      unitShort: json['unitShort'],
      unitLong: json['unitLong'],
    );
  }
}
