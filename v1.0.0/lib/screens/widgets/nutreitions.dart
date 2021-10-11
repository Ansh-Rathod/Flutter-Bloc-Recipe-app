import 'package:expandable/expandable.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:racipi/models/meal_plan.dart';
import 'package:racipi/models/nutrients.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NutrientsWidgets extends StatelessWidget {
  final Nutrient nutrient;

  const NutrientsWidgets({Key key, this.nutrient}) : super(key: key);

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
                "Nutrients",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            items: [
              ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineIcons.fire,
                      size: 35,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text(
                    "calories",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    nutrient.calories,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  )),
              ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.face_outlined,
                      size: 35,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text(
                    "Fat",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    nutrient.fat,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  )),
              ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.bakery_dining,
                      size: 35,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text(
                    "carbohydrates",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    nutrient.carbs,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  )),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bolt_outlined,
                    size: 35,
                    color: Colors.orange,
                  ),
                ),
                title: Text(
                  "Protein",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  nutrient.protein,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutrientsbadWidget extends StatelessWidget {
  final Nutrient nutrient;

  const NutrientsbadWidget({Key key, this.nutrient}) : super(key: key);

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
                "Bad for health Nutrients.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            items: [
              ...nutrient.bad.map((nutri) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  // leading: CircularPercentIndicator(
                  //   radius: 50.0,
                  //   lineWidth: 5.0,
                  //   percent: nutri.percentOfDailyNeeds / 100,
                  //   center: new Text(
                  //     nutri.percentOfDailyNeeds.toString() + "%",
                  //     style:
                  //         TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  //   ),
                  //   progressColor: Colors.green,
                  // ),
                  subtitle:
                      Text("${nutri.percentOfDailyNeeds}% of Daily needs."),

                  title: Text(
                    "${nutri.name.toString()}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${nutri.amount}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}

class NutrientsgoodWidget extends StatelessWidget {
  final Nutrient nutrient;

  const NutrientsgoodWidget({Key key, this.nutrient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: ExpandableGroup(
            isExpanded: false,
            collapsedIcon: Icon(Icons.arrow_drop_down),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "good for health Nutrients.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            items: [
              ...nutrient.good.map((nutri) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  subtitle:
                      Text("${nutri.percentOfDailyNeeds}% of Daily needs."),
                  title: Text(
                    "${nutri.name.toString()}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${nutri.amount}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
