import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/Faliure.dart';
import '../../../models/equipment.dart';
import '../../../models/nutrients.dart';
import '../../../models/racipe.dart';
import '../../../models/similar_list.dart';
import '../../../repo/get_random_racipe.dart';

part 'random_recipe_event.dart';
part 'random_recipe_state.dart';

class RandomRecipeBloc extends Bloc<RandomRecipeEvent, RandomRecipeState> {
  final GetRandomRecipe repo = GetRandomRecipe();
  RandomRecipeBloc() : super(RandomRecipeInitial()) {
    // ignore: void_checks
    on<RandomRecipeEvent>((event, emit) async {
      if (event is LoadRandomRecipe) {
        try {
          emit(RandomRecipeLoadState());
          final data = await repo.getRecipe();
          emit(
            RandomRecipeSuccesState(
              recipe: data[0],
              nutrient: data[3],
              similar: data[1].list,
              equipment: data[2].items,
            ),
          );
        } on Failure catch (e) {
          emit(FailureState(error: e));
        } catch (e) {
          print(e.toString());
          emit(RandomRecipeErrorState());
        }
      }
    });
  }
}
