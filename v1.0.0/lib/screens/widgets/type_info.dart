import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class TypeInfo extends StatelessWidget {
  final Recipe recipe;
  const TypeInfo({
    Key key,
    this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ExpandableGroup(
              isExpanded: false,
              collapsedIcon: Icon(Icons.arrow_drop_down),
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Meal Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              items: [
                if (recipe.dishTypes.isNotEmpty)
                  ListTile(
                    title: Text("Dish Type"),
                    subtitle: Wrap(
                      children: [
                        ...recipe.dishTypes
                            .map((data) => Text(data + ","))
                            .toList(),
                      ],
                    ),
                  ),
                if (recipe.diets.isNotEmpty)
                  ListTile(
                    title: Text("Diets"),
                    subtitle: Wrap(
                      children: [
                        ...recipe.diets
                            .map((data) => Text(data + ","))
                            .toList(),
                      ],
                    ),
                  ),
                if (recipe.occasions.isNotEmpty)
                  ListTile(
                    title: Text("occasions"),
                    subtitle: Wrap(
                      children: [
                        ...recipe.occasions
                            .map((data) => Text(data + ","))
                            .toList(),
                      ],
                    ),
                  ),
                if (recipe.cuisines.isNotEmpty)
                  ListTile(
                    title: Text("cuisines"),
                    subtitle: Wrap(
                      children: [
                        ...recipe.cuisines
                            .map((data) => Text(data + ","))
                            .toList(),
                      ],
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}
