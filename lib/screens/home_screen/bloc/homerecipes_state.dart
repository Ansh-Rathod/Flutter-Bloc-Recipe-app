part of 'homerecipes_bloc.dart';

@immutable
abstract class HomeRecipesState {}

class HomeRecipesInitial extends HomeRecipesState {}

class HomeRecipesLoading extends HomeRecipesState {}

class HomeRecipesSuccess extends HomeRecipesState {
  final List<FoodType> breakfast;
  final List<FoodType> lunch;
  final List<FoodType> drinks;
  final List<FoodType> burgers;
  final List<FoodType> pizza;
  final List<FoodType> cake;
  final List<FoodType> rice;
  HomeRecipesSuccess({
    required this.breakfast,
    required this.lunch,
    required this.drinks,
    required this.burgers,
    required this.pizza,
    required this.cake,
    required this.rice,
  });
}

class HomeRecipesError extends HomeRecipesState {}

class HomeFailureState extends HomeRecipesState {
  final Failure error;

  HomeFailureState({required this.error});
}
