import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:racipi/models/meal_plan.dart';
import 'package:racipi/models/nutrients.dart';
import 'package:racipi/screens/widgets/nutreitions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/equipments.dart';
import '../../models/recipe.dart';
import '../../models/similar.dart';
import '../../theme/colors.dart';
import 'coustom_app_bar.dart';
import 'equipments.dart';
import 'ingredients.dart';
import 'similar_screen.dart';
import 'true_false_table.dart';
import 'type_info.dart';

class CustomRecipeInfo extends StatelessWidget {
  final Recipe recipe;
  final List<Similar> similar;
  final Nutrient nutrient;
  final List<Equipments> equipment;
  const CustomRecipeInfo({
    Key key,
    this.recipe,
    this.similar,
    this.equipment,
    this.nutrient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: athens_gray,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: MySliverAppBar(
              recipe.image,
              recipe.title,
              recipe,
              expandedHeight: 300,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  recipe.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(recipe.readyInMinutes.toString() + " Min",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("TOTAL TIME", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Container(height: 30, width: 2, color: Colors.black),
                    Column(
                      children: [
                        Text(recipe.servings.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("SERVINGS", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    Container(height: 30, width: 2, color: Colors.black),
                    Column(
                      children: [
                        Text(recipe.pricePerServing.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("PRICE/SERVING",
                            style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Ingredients",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          if (recipe.extendedIngredients.isNotEmpty)
            IngredientsWidget(
              recipe: recipe,
            ),
          if (recipe.instructions != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instructions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Html(
                        data: recipe.instructions,
                        onLinkTap: (String url,
                            RenderContext context,
                            Map<String, String> attributes,
                            dom.Element element) {
                          launch(url);
                        }),
                  ],
                ),
              ),
            ),
          if (equipment.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Equipments",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          if (equipment.isNotEmpty)
            EquipmentsListView(
              equipments: equipment,
            ),
          if (recipe.summary != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Html(
                        data: recipe.summary,
                        onLinkTap: (String url,
                            RenderContext context,
                            Map<String, String> attributes,
                            dom.Element element) {
                          launch(url);
                        }),
                  ],
                ),
              ),
            ),
          TrueFalseTable(
            recipe: recipe,
          ),
          TypeInfo(
            recipe: recipe,
          ),
          NutrientsWidgets(
            nutrient: nutrient,
          ),
          NutrientsbadWidget(
            nutrient: nutrient,
          ),
          NutrientsgoodWidget(
            nutrient: nutrient,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          if (similar.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Text("Similar items",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
          if (similar.isNotEmpty)
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SimilarListWidget(items: similar),
            )),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 20,
          )),
        ],
      ),
    );
  }
}
