import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlan {
  final String id;
  final String name;
  final String image;
  final String readyInMinutes;
  final String servings;
  MealPlan({
    this.id,
    this.name,
    this.image,
    this.readyInMinutes,
    this.servings,
  });
  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      id: json['id'].toString(),
      name: json['title'],
      image:
          "https://spoonacular.com/recipeImages/${json['id']}-556x370.${json['imageType']}",
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
}

class Nutrients {
  final String calories;
  final String protein;
  final String fat;
  final String carbohydrates;
  Nutrients({
    this.calories,
    this.protein,
    this.fat,
    this.carbohydrates,
  });
  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
      calories: json["calories"].toString(),
      protein: json['protein'].toString(),
      fat: json['fat'].toString(),
      carbohydrates: json['carbohydrates'].toString(),
    );
  }
}

class MealPlanList {
  final List<MealPlan> list;
  final Nutrients nutrient;
  MealPlanList({this.list, this.nutrient});

  factory MealPlanList.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final json = doc.data();
    return MealPlanList(
      list: (json['meals'] as List)
          .map((data) => MealPlan.fromJson(data))
          .toList(),
      nutrient: Nutrients.fromJson(json['nutrients']),
    );
  }
}
