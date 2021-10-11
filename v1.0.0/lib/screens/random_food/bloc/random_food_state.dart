part of 'random_food_bloc.dart';

class RandomFoodState {}

class RandomFoodInitial extends RandomFoodState {}

class RandomFoodLoadState extends RandomFoodState {}

class RandomFoodSuccesState extends RandomFoodState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipments> equipment;
  final Nutrient nutrient;
  RandomFoodSuccesState({
    this.recipe,
    this.nutrient,
    this.similar,
    this.equipment,
  });
}

class RandomFoodErrorState extends RandomFoodState {}

class FailureState extends RandomFoodState {
  final Failure error;

  FailureState({this.error});
}
