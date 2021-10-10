import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/Faliure.dart';
import '../../../models/equipment.dart';
import '../../../models/nutrients.dart';
import '../../../models/racipe.dart';
import '../../../models/similar_list.dart';
import '../../../repo/get_recipe_info.dart';

part 'recipe_info_event.dart';
part 'recipe_info_state.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  final GetRecipeInfo repo = GetRecipeInfo();

  RecipeInfoBloc() : super(RecipeInfoInitial()) {
    on<RecipeInfoEvent>((event, emit) async {
      if (event is LoadRecipeInfo) {
        try {
          emit(RecipeInfoLoadState());
          final data = await repo.getRecipeInfo(event.id);
          emit(
            RecipeInfoSuccesState(
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
          emit(RecipeInfoErrorState());
        }
      }
    });
  }
}
