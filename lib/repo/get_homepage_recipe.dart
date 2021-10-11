import 'dart:math';

import 'package:dio/dio.dart';
import 'package:recipia/api/api_key.dart';
import 'package:recipia/models/faliure.dart';
import 'package:recipia/models/food_type.dart';
import 'package:recipia/repo/get_recipe_info.dart';

class GetHomeRecipes {
  var key = ApiKey.keys;
  // ignore: non_constant_identifier_names

  final dio = Dio();

  Future<FoodTypeList> getRecipes(String type, int no) async {
    var url = BASE_URL +
        "/random?number=$no&tags=$type" +
        '&apiKey=' +
        key;
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return FoodTypeList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: response.data['message']);
    } else {
      print(response.statusCode);
      throw Failure(
          code: response.statusCode!, message: response.statusMessage!);
    }
  }
}
