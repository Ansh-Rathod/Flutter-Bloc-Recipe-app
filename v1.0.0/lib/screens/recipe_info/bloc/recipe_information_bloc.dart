import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:racipi/models/nutrients.dart';
import '../../../models/equipments.dart';
import '../../../models/failure.dart';
import '../../../models/recipe.dart';
import '../../../models/similar.dart';
import '../../../repo/random_food_repo.dart';
import '../../../repo/recipe_information.dart';

part 'recipe_information_event.dart';
part 'recipe_information_state.dart';

class RecipeInformationBloc
    extends Bloc<RecipeInformationEvent, RecipeInformationState> {
  RecipeInformationBloc() : super(RecipeInformationInitial());
  final repo = RecipeInformation();

  @override
  Stream<RecipeInformationState> mapEventToState(
    RecipeInformationEvent event,
  ) async* {
    if (event is LoadInformationFood) {
      try {
        yield RecipeInformationLoadState();
        final recipe = await repo.getRecipeInformationFood(event.id);
        final similar = await repo.getSimilarFood(recipe.id.toString());
        final equipments = await repo.getEquipments(recipe.id.toString());
        final nutrient = await repo.getNutrient(recipe.id.toString());

        yield RecipeInformationSuccesState(
          recipe: recipe,
          similar: similar.list,
          equipment: equipments.items,
          nutrient: nutrient,
        );
      } on Failure catch (e) {
        yield FailureState(error: e);
      } catch (e) {
        print(e.toString());
        yield RecipeInformationErrorState();
      }
    }
  }
}
