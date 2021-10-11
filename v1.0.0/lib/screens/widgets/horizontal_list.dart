import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racipi/screens/search_results/bloc/search_results_bloc.dart';
import 'package:racipi/screens/search_results/search_result.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 16),
          ChipWidget("Drinks"),
          SizedBox(width: 16),
          ChipWidget("Baking"),
          SizedBox(width: 16),
          ChipWidget("Desserts"),
          SizedBox(width: 16),
          ChipWidget("Vegetarian"),
          SizedBox(width: 16),
          ChipWidget("Sauces"),
          SizedBox(width: 16),
          ChipWidget("Stir Fry"),
          SizedBox(width: 16),
          ChipWidget("Seafood"),
          SizedBox(width: 16),
          ChipWidget("Meat"),
          SizedBox(width: 16),
          ChipWidget("Lamb"),
          SizedBox(width: 16),
          ChipWidget("Pork"),
          SizedBox(width: 16),
          ChipWidget("Poultry"),
          SizedBox(width: 16),
          ChipWidget("Duck"),
          SizedBox(width: 16),
          ChipWidget("Turkey"),
          SizedBox(width: 16),
          ChipWidget("Chicken"),
          SizedBox(width: 16),
          ChipWidget("Sausages"),
          SizedBox(width: 16),
          ChipWidget("Mince"),
          SizedBox(width: 16),
          ChipWidget("Burgers"),
          SizedBox(width: 16),
          ChipWidget("Pies"),
          SizedBox(width: 16),
          ChipWidget("Pasta"),
          SizedBox(width: 16),
          ChipWidget("Noodles"),
          SizedBox(width: 16),
          ChipWidget("Rice"),
          SizedBox(width: 16),
          ChipWidget("Pizza"),
          SizedBox(width: 16),
          ChipWidget("Sides"),
          SizedBox(width: 16),
          ChipWidget("Salads"),
          SizedBox(width: 16),
          ChipWidget("Soups"),
          SizedBox(width: 16),
          ChipWidget("Snacks"),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class ChipWidget extends StatelessWidget {
  final String text;
  const ChipWidget(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => SearchResultsBloc()
                        ..add(LoadSearchResults(searchtext: text)),
                      child: SearchResults(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16)),
      ),
    );
  }
}
