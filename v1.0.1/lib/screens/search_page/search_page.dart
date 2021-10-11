import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipia/animation/animation.dart';
import 'package:recipia/models/auto_complete.dart';
import 'package:recipia/screens/home_screen/widgets/horizonal_list.dart';
import 'package:recipia/screens/recipe_info/bloc/recipe_info_bloc.dart';
import 'package:recipia/screens/recipe_info/recipe_info_screen.dart';
import 'package:recipia/screens/search_page/cubit/search_page_cubit.dart';
import 'package:recipia/screens/search_results/bloc/search_results_bloc.dart';
import 'package:recipia/screens/search_results/search_results_screen.dart';
import 'package:recipia/widgets/loading_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
        builder: (context, state) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search Recipes..",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.redAccent),
                        onPressed: () {},
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.black.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(15))),
                  onChanged: (value) {
                    BlocProvider.of<SearchPageCubit>(context).textChange(value);
                  },
                  onSubmitted: (v) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => SearchResultsBloc(),
                          child: SearchResults(
                            id: v,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          body: SafeArea(
              child: (state.status == Status.success &&
                      state.searchList.isNotEmpty)
                  ? ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ...state.searchList.map((list) {
                          return SearchAutoCompleteTile(list: list);
                        }).toList()
                      ],
                    )
                  : state.status == Status.loading
                      ? const Center(child: LoadingWidget())
                      : ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 20),
                              child: Text(
                                "Most Recent Searches by People",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: const [
                                  ChipWidget("Baking"),
                                  ChipWidget("Vegetarian"),
                                  ChipWidget("Sauces"),
                                  ChipWidget("Meat"),
                                  ChipWidget("Turkey"),
                                  ChipWidget("Chicken"),
                                  ChipWidget("Sausages"),
                                  ChipWidget("Mince"),
                                  ChipWidget("Burgers"),
                                  ChipWidget("Pasta"),
                                  ChipWidget("Noodles"),
                                  ChipWidget("Pizza"),
                                  ChipWidget("Soups"),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Text(
                                "Recipes by categories",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const CategoryTile(
                                text: "main course",
                                image:
                                    "https://images.unsplash.com/photo-1559847844-5315695dadae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=740&q=80"),
                            const CategoryTile(
                                text: "side dish",
                                image:
                                    "https://images.unsplash.com/photo-1534938665420-4193effeacc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80"),
                            const CategoryTile(
                                text: "dessert",
                                image:
                                    "https://images.unsplash.com/photo-1587314168485-3236d6710814?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=670&q=80"),
                            const CategoryTile(
                                text: "appetizer",
                                image:
                                    "https://images.unsplash.com/photo-1541529086526-db283c563270?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                            const CategoryTile(
                              text: "salad",
                              image:
                                  "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                            ),
                            const CategoryTile(
                              text: "bread",
                              image:
                                  "https://images.unsplash.com/photo-1509440159596-0249088772ff?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80",
                            ),
                            const CategoryTile(
                              text: "breakfast",
                              image:
                                  "https://images.unsplash.com/photo-1525351484163-7529414344d8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                            ),
                            const CategoryTile(
                              text: "soup",
                              image:
                                  "https://images.unsplash.com/photo-1547592166-23ac45744acd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80",
                            ),
                            const CategoryTile(
                              text: "beverage",
                              image:
                                  "https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            const CategoryTile(
                              text: "sauce",
                              image:
                                  "https://images.unsplash.com/photo-1472476443507-c7a5948772fc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            const CategoryTile(
                              text: "marinade",
                              image:
                                  "https://images.unsplash.com/photo-1598511757337-fe2cafc31ba0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            const CategoryTile(
                              text: "fingerfood",
                              image:
                                  "https://images.unsplash.com/photo-1605333396915-47ed6b68a00e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            const CategoryTile(
                              text: "snack",
                              image:
                                  "https://images.unsplash.com/photo-1599490659213-e2b9527bd087?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            const CategoryTile(
                              text: "drink",
                              image:
                                  "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                            ),
                          ],
                        )),
        ),
      );
    });
  }
}

class CategoryTile extends StatelessWidget {
  final String text;
  final String image;
  const CategoryTile({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(-2, -2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.05),
            ),
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 0.10),
            )
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ListTile(
              leading: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover))),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SearchResultsBloc(),
                      child: SearchResults(
                        id: text,
                      ),
                    ),
                  ),
                );
              },
              title: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_right_alt)),
        ),
      ),
    );
  }
}

class SearchAutoCompleteTile extends StatefulWidget {
  final SearchAutoComplete list;
  const SearchAutoCompleteTile({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _SearchAutoCompleteTileState createState() => _SearchAutoCompleteTileState();
}

class _SearchAutoCompleteTileState extends State<SearchAutoCompleteTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            offset: Offset(-2, -2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.10),
          )
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => RecipeInfoBloc(),
                      child: RecipeInfo(
                        id: widget.list.id,
                      ),
                    )));
          },
          leading: Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.list.image))),
          ),
          title: Text(
            widget.list.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
