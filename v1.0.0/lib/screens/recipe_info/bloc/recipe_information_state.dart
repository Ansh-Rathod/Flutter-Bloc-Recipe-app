part of 'recipe_information_bloc.dart';

class RecipeInformationState {}

class RecipeInformationInitial extends RecipeInformationState {}

class RecipeInformationLoadState extends RecipeInformationState {}

class RecipeInformationSuccesState extends RecipeInformationState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipments> equipment;
  final Nutrient nutrient;

  RecipeInformationSuccesState({
    this.recipe,
    this.nutrient,
    this.equipment,
    this.similar,
  });
}

class RecipeInformationErrorState extends RecipeInformationState {}

class FailureState extends RecipeInformationState {
  final Failure error;

  FailureState({this.error});
}
