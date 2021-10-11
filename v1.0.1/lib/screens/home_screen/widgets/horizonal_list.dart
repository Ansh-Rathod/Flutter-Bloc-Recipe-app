import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipia/animation/animation.dart';
import 'package:recipia/screens/search_results/bloc/search_results_bloc.dart';
import 'package:recipia/screens/search_results/search_results_screen.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(width: 10),
          ChipWidget("Drinks"),
          ChipWidget("Baking"),
          ChipWidget("Desserts"),
          ChipWidget("Vegetarian"),
          ChipWidget("Sauces"),
          ChipWidget("Stir Fry"),
          ChipWidget("Seafood"),
          ChipWidget("Meat"),
          ChipWidget("Lamb"),
          ChipWidget("Pork"),
          ChipWidget("Poultry"),
          ChipWidget("Duck"),
          ChipWidget("Turkey"),
          ChipWidget("Chicken"),
          ChipWidget("Sausages"),
          ChipWidget("Mince"),
          ChipWidget("Burgers"),
          ChipWidget("Pies"),
          ChipWidget("Pasta"),
          ChipWidget("Noodles"),
          ChipWidget("Rice"),
          ChipWidget("Pizza"),
          ChipWidget("Sides"),
          ChipWidget("Salads"),
          ChipWidget("Soups"),
          ChipWidget("Snacks"),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: InkWell(
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
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-2, -2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
