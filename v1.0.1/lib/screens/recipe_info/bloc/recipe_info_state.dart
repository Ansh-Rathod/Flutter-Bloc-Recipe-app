part of 'recipe_info_bloc.dart';

@immutable
abstract class RecipeInfoState {}

class RecipeInfoInitial extends RecipeInfoState {}

class RecipeInfoLoadState extends RecipeInfoState {}

class RecipeInfoSuccesState extends RecipeInfoState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipment> equipment;
  final Nutrient nutrient;

  RecipeInfoSuccesState({
    required this.recipe,
    required this.nutrient,
    required this.similar,
    required this.equipment,
  });
}

class RecipeInfoErrorState extends RecipeInfoState {}

class FailureState extends RecipeInfoState {
  final Failure error;

  FailureState({required this.error});
}
