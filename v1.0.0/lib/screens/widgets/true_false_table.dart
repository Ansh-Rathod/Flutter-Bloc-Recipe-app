import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class TrueFalseTable extends StatelessWidget {
  final Recipe recipe;
  const TrueFalseTable({
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ExpandableGroup(
            isExpanded: false,
            collapsedIcon: Icon(Icons.arrow_drop_down),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Dish Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            items: [
              ListTile(
                title: Text("Vegetarian"),
                trailing: (recipe.vegetarian)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Vegan"),
                trailing: (recipe.vegan)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Gluten Free"),
                trailing: (recipe.glutenFree)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Dairy Free"),
                trailing: (recipe.dairyFree)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Very Healthy"),
                trailing: (recipe.vegetarian)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Cheap"),
                trailing: (recipe.cheap)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Very Popular"),
                trailing: (recipe.veryPopular)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
              ListTile(
                title: Text("Sustainable"),
                trailing: (recipe.sustainable)
                    ? Icon(
                        Icons.done_outline_rounded,
                        color: Colors.green,
                      )
                    : Icon(Icons.cancel, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
