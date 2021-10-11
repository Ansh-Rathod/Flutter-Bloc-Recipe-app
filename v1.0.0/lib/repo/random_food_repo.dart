import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:racipi/models/nutrients.dart';

import '../api/api_key.dart';
import '../models/equipments.dart';
import '../models/failure.dart';
import '../models/recipe.dart';
import '../models/similar.dart';

class RandomFoodRepo {
  final String apiKey = ApiKey.key;
  Future<Recipe> getRandomFood() async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=1&apiKey=$apiKey');
    var response = await http.get(url);
    var body = json.decode(response.body);
    print("get random food: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return Recipe.fromJson(body['recipes'][0]);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<SimilarList> getSimilarFood(String id) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/$id/similar?apiKey=${apiKey[Random().nextInt(14)]}');
    var response = await http.get(url);
    var body = json.decode(response.body);
    print("get similar food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return SimilarList.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<EquipmentsList> getEquipments(String id) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/$id/equipmentWidget.json?apiKey=${apiKey[Random().nextInt(14)]}');
    var response = await http.get(url);
    var body = json.decode(response.body);
    print("get Equipments food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return EquipmentsList.fromJson(body['equipment']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }

  Future<Nutrient> getNutrient(String id) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/$id/nutritionWidget.json?apiKey=${apiKey[Random().nextInt(14)]}');
    var response = await http.get(url);
    var body = json.decode(response.body);
    print("get Equipments food :" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return Nutrient.fromJson(body);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: body['message']);
    } else {
      var msg = 'Something went wrong';
      if (body.containsKey('message')) {
        msg = body['message'];
      }
      throw Failure(code: response.statusCode, message: msg);
    }
  }
}
