class Length {
  int? number;
  String? unit;

  Length({this.number, this.unit});

  factory Length.fromJson(json) => Length(
        number: json['number'] as int?,
        unit: json['unit'] as String?,
      );

  toJson() => {
        'number': number,
        'unit': unit,
      };
}
