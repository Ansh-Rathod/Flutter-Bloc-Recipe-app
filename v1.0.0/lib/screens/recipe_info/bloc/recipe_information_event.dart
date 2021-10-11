part of 'recipe_information_bloc.dart';

class RecipeInformationEvent {}

class LoadInformationFood extends RecipeInformationEvent {
  final String id;
  LoadInformationFood({
    this.id,
  });
}
