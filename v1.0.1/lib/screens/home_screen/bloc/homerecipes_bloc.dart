import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipia/models/faliure.dart';
import 'package:recipia/models/food_type.dart';
import 'package:recipia/repo/get_homepage_recipe.dart';

part 'homerecipes_event.dart';
part 'homerecipes_state.dart';

class HomeRecipesBloc extends Bloc<HomeRecipesEvent, HomeRecipesState> {
  final repo = GetHomeRecipes();
  HomeRecipesBloc() : super(HomeRecipesInitial()) {
    on<HomeRecipesEvent>((event, emit) async {
      if (event is LoadHomeRecipe) {
        try {
          emit(HomeRecipesLoading());
          final data = await Future.wait([
            repo.getRecipes('breakfast', 20),
            repo.getRecipes('lunch', 3),
            repo.getRecipes('drinks', 20),
            repo.getRecipes('pizza', 3),
            repo.getRecipes('burgers', 20),
            repo.getRecipes('cake', 20),
            repo.getRecipes('rice', 20),
          ]);
          emit(
            HomeRecipesSuccess(
              breakfast: data[0].list,
              lunch: data[1].list,
              rice: data[6].list,
              drinks: data[2].list,
              burgers: data[4].list,
              pizza: data[3].list,
              cake: data[5].list,
            ),
          );
        } on Failure catch (e) {
          emit(HomeFailureState(error: e));
        } catch (e) {
          print(e.toString());
          emit(HomeRecipesError());
        }
      }
    });
  }
}
