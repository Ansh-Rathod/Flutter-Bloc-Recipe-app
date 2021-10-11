import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bloc/recipe_information_bloc.dart';
import '../widgets/scroll_view_recipe_info.dart';

class RecipeInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeInformationBloc, RecipeInformationState>(
      builder: (context, state) {
        if (state is RecipeInformationLoadState) {
          return Scaffold(
              body: Center(
                  child: SpinKitCircle(
            color: Colors.green,
            size: 50,
          )));
        } else if (state is RecipeInformationSuccesState) {
          print(state.recipe.id);
          print(state.recipe.image);
          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: CustomRecipeInfo(
                recipe: state.recipe,
                equipment: state.equipment,
                similar: state.similar,
                nutrient: state.nutrient,
              ),
            ),
          );
        } else if (state is RecipeInformationErrorState) {
          return Scaffold(
              body: Container(
                  child: Center(child: Text("Something wents Wrong"))));
        } else if (state is FailureState) {
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${state.error.code} Error",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Text(
                  "${state.error.message}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ));
        } else {
          return Scaffold();
        }
      },
    );
  }
}
