import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/recipe.dart';

class IngredientsWidget extends StatelessWidget {
  final Recipe recipe;
  const IngredientsWidget({
    Key key,
    this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: 170,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        children: [
          ...recipe.extendedIngredients.map((ingredient) {
            return InkWell(
              onTap: () {
                return showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Material(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 20),
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      "https://spoonacular.com/cdn/ingredients_500x500/${ingredient.image}")),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              ingredient.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          if (ingredient.name != ingredient.nameClean)
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text("(${ingredient.nameClean})")),
                          SizedBox(height: 40),
                          Container(
                              child: Text(
                            "for ${ingredient.aisle}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(height: 10),
                          Container(
                              child: Row(
                            children: [
                              Text(
                                "consistency: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${ingredient.consistency}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )),
                          SizedBox(height: 10),
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                children: [
                                  TextSpan(
                                      text: "Amount: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: ingredient.original,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}")),
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        ingredient.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    ));
  }
}
