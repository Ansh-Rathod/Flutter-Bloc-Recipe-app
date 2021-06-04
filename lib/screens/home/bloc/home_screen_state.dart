part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSuccess extends HomeScreenState {
  final List<MealPlan> mealPlan;
  final Nutrients nutrients;
  final List<FoodType> breakfast;
  final List<FoodType> lunch;
  final List<FoodType> drinks;
  final List<FoodType> burgers;
  final List<FoodType> pizza;
  final List<FoodType> cake;
  final List<FoodType> rice;

  HomeScreenSuccess({
    this.cake,
    this.rice,
    this.mealPlan,
    this.nutrients,
    this.breakfast,
    this.lunch,
    this.drinks,
    this.burgers,
    this.pizza,
  });
}

class HomeScreenError extends HomeScreenState {}

class HomeFailureState extends HomeScreenState {
  final Failure error;

  HomeFailureState({this.error});
}
