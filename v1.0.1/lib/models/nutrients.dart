import 'dart:convert';

class Nutrient {
  final String calories;
  final String carbs;
  final String fat;
  final String protein;
  final List<Needs> good;
  final List<Needs> bad;
  Nutrient({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.good,
    required this.bad,
    required this.protein,
  });
  factory Nutrient.fromJson(json) {
    return Nutrient(
      calories: json['calories'],
      carbs: json['carbs'],
      fat: json['fat'],
      protein: json['protein'],
      bad: (json['bad'] as List).map((hmm) => Needs.formJson(hmm)).toList(),
      good: (json['good'] as List).map((hmm) => Needs.formJson(hmm)).toList(),
    );
  }
}

class Needs {
  final String name;
  final String amount;
  final String percentOfDailyNeeds;
  Needs({
    required this.name,
    required this.amount,
    required this.percentOfDailyNeeds,
  });
  factory Needs.formJson(json) {
    return Needs(
      name: json.containsKey('title') ? json['title'] : json['name'],
      amount: json['amount'],
      percentOfDailyNeeds: json['percentOfDailyNeeds'].toString(),
    );
  }
}
