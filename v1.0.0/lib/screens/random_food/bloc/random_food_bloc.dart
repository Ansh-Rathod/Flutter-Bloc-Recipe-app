import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:racipi/models/nutrients.dart';

import '../../../models/equipments.dart';
import '../../../models/failure.dart';
import '../../../models/recipe.dart';
import '../../../models/similar.dart';
import '../../../repo/random_food_repo.dart';

part 'random_food_event.dart';
part 'random_food_state.dart';

class RandomFoodBloc extends Bloc<RandomFoodEvent, RandomFoodState> {
  RandomFoodBloc() : super(RandomFoodInitial());
  final repo = RandomFoodRepo();
  @override
  Stream<RandomFoodState> mapEventToState(
    RandomFoodEvent event,
  ) async* {
    if (event is LoadRandomFood) {
      try {
        yield RandomFoodLoadState();
        final recipe = await repo.getRandomFood();
        final similar = await repo.getSimilarFood(recipe.id.toString());
        final nutrient = await repo.getNutrient(recipe.id.toString());

        final equipments = await repo.getEquipments(recipe.id.toString());
        yield RandomFoodSuccesState(
            recipe: recipe,
            similar: similar.list,
            nutrient: nutrient,
            equipment: equipments.items);
      } on Failure catch (e) {
        yield FailureState(error: e);
      } catch (e) {
        print(e.toString());
        yield RandomFoodErrorState();
      }
    }
  }
}
