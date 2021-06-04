import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:racipi/models/type_model.dart';
import 'package:racipi/screens/home/bloc/home_screen_bloc.dart';
import 'package:racipi/screens/random_food/bloc/random_food_bloc.dart';
import 'package:racipi/screens/random_food/random_food_screen.dart';
import 'package:racipi/screens/recipe_info/bloc/recipe_information_bloc.dart';
import 'package:racipi/screens/recipe_info/recipe_info.dart';
import 'package:racipi/screens/search_results/bloc/search_results_bloc.dart';
import 'package:racipi/screens/search_results/search_result.dart';
import 'package:racipi/screens/widgets/Recipe_list_view_item.dart';
import 'package:racipi/screens/widgets/food_by_type.dart';
import 'package:racipi/screens/widgets/horizontal_list.dart';
import 'package:racipi/screens/widgets/today_meal.dart';
import 'package:racipi/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenLoading) {
          return Scaffold(
              body: Center(
                  child: SpinKitCircle(
            color: Colors.green,
            size: 50,
          )));
        } else if (state is HomeScreenSuccess) {
          return Scaffold(
            backgroundColor: athens_gray,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Spoonacular",
                style: GoogleFonts.lobster(
                    textStyle: TextStyle(color: Colors.green, fontSize: 20)),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                tooltip: "Random Food",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<RandomFoodBloc>(
                          create: (_) =>
                              RandomFoodBloc()..add(LoadRandomFood()),
                          child: RandomFoodScreen(),
                        ),
                      ));
                },
                child: Icon(Icons.ramen_dining_sharp)),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: athens_gray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        child: Text(
                          "Simple Way to find \nTasty food",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    HorizontalList(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onSubmitted: (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => SearchResultsBloc()
                                          ..add(LoadSearchResults(
                                              searchtext: value)),
                                        child: SearchResults(),
                                      )));
                        },
                        decoration: InputDecoration(
                            hintText: "Search Recipes..",
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {}),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 5,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Popular Breakfast \nRecipes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  SearchResultsBloc()
                                                    ..add(LoadSearchResults(
                                                        searchtext:
                                                            "Breakfast")),
                                              child: SearchResults(),
                                            )));
                              },
                              icon: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    FoodTypeWidget(items: state.breakfast),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Best Lunch Recipes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => BlocProvider(
                                                        create: (context) =>
                                                            SearchResultsBloc()
                                                              ..add(LoadSearchResults(
                                                                  searchtext:
                                                                      "lunch")),
                                                        child: SearchResults(),
                                                      )));
                                    },
                                    icon: Icon(Icons.arrow_forward_sharp))
                              ],
                            ),
                          ),
                          ...state.lunch.map((meal) {
                            return ListItem(
                              meal: meal,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Popular Drinks",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  SearchResultsBloc()
                                                    ..add(LoadSearchResults(
                                                        searchtext: "drinks")),
                                              child: SearchResults(),
                                            )));
                              },
                              icon: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                    FoodTypeWidget(items: state.drinks),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TodaysMeal(
                        mealPlan: state.mealPlan,
                        nutrients: state.nutrients,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Pizza recipes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  SearchResultsBloc()
                                                    ..add(LoadSearchResults(
                                                        searchtext: "pizza")),
                                              child: SearchResults(),
                                            )));
                              },
                              icon: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                    FoodTypeWidget(items: state.pizza),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Best burgers Recipes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (context) =>
                                                        SearchResultsBloc()
                                                          ..add(LoadSearchResults(
                                                              searchtext:
                                                                  "burgers")),
                                                    child: SearchResults(),
                                                  )));
                                    },
                                    icon: Icon(Icons.arrow_forward_sharp))
                              ],
                            ),
                          ),
                          ...state.burgers.map((meal) {
                            return ListItem(
                              meal: meal,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Popular cakes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  SearchResultsBloc()
                                                    ..add(LoadSearchResults(
                                                        searchtext: "cake")),
                                              child: SearchResults(),
                                            )));
                              },
                              icon: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                    FoodTypeWidget(items: state.cake),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Tasty pasta",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  SearchResultsBloc()
                                                    ..add(LoadSearchResults(
                                                        searchtext: "pasta")),
                                              child: SearchResults(),
                                            )));
                              },
                              icon: Icon(Icons.arrow_forward_sharp))
                        ],
                      ),
                    ),
                    FoodTypeWidget(items: state.rice),
                  ],
                ),
              ),
            ),
          );
        } else if (state is HomeScreenError) {
          return Scaffold(
              body: Container(
                  child: Center(child: Text("Something wents Wrong"))));
        } else if (state is HomeFailureState) {
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
