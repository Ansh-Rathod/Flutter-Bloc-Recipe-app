import 'dart:math';

import 'package:dio/dio.dart';
import 'package:recipia/api/api_key.dart';
import '../models/Faliure.dart';
import '../models/equipment.dart';
import '../models/nutrients.dart';
import '../models/racipe.dart';
import '../models/similar_list.dart';

// ignore: constant_identifier_names
const BASE_URL = 'https://api.spoonacular.com/recipes/';
// ignore: constant_identifier_names
const EQUIPMENTS_PATH = '/equipmentWidget.json?';
// ignore: constant_identifier_names
const NUTRITION_PATH = '/nutritionWidget.json?';
// ignore: constant_identifier_names
const INFORMATION_PATH = '/information?';
// ignore: constant_identifier_names
const SIMILAR_PATH = '/similar?';

class GetRecipeInfo {
  // ignore: non_constant_identifier_names
  var key = ApiKey.keys;

  final dio = Dio();

  Future<List<dynamic>> getRecipeInfo(String id) async {
    var infoUrl = BASE_URL +
        id +
        INFORMATION_PATH +
        '&apiKey=' +
        key;
    var similarUrl =
        BASE_URL + id + SIMILAR_PATH + '&apiKey=' + key;
    var equipmentUrl = BASE_URL +
        id +
        EQUIPMENTS_PATH +
        '&apiKey=' +
        key;
    var nutritionUrl =
        BASE_URL + id + NUTRITION_PATH + '&apiKey=' + key;

    Recipe racipeInfo;
    SimilarList similarList;
    EquipmentsList equipmentList;
    Nutrient nutrients;
    final response = await Future.wait([
      dio.get(infoUrl),
      dio.get(similarUrl),
      dio.get(equipmentUrl),
      dio.get(nutritionUrl),
    ]);
    if (response[0].statusCode == 200) {
      racipeInfo = Recipe.fromJson(response[0].data);
    } else if (response[0].statusCode == 401) {
      throw Failure(code: 401, message: response[0].data['message']);
    } else {
      throw Failure(
          code: response[0].statusCode!, message: response[0].statusMessage!);
    }
    if (response[1].statusCode == 200) {
      similarList = SimilarList.fromJson(response[1].data);
    } else if (response[1].statusCode == 401) {
      throw Failure(code: 401, message: response[1].data['message']);
    } else {
      throw Failure(
          code: response[1].statusCode!, message: response[1].statusMessage!);
    }
    if (response[2].statusCode == 200) {
      equipmentList = EquipmentsList.fromJson(response[2].data['equipment']);
    } else if (response[2].statusCode == 401) {
      throw Failure(code: 401, message: response[2].data['message']);
    } else {
      throw Failure(
          code: response[2].statusCode!, message: response[2].statusMessage!);
    }
    if (response[3].statusCode == 200) {
      nutrients = Nutrient.fromJson(response[3].data);
    } else if (response[3].statusCode == 401) {
      throw Failure(code: 401, message: response[3].data['message']);
    } else {
      throw Failure(
          code: response[3].statusCode!, message: response[3].statusMessage!);
    }

    return [
      racipeInfo,
      similarList,
      equipmentList,
      nutrients,
    ];
  }
}
