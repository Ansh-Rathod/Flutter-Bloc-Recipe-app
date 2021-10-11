import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:racipi/models/meal_plan.dart';
import 'package:racipi/screens/home/widgets/nutritrents_row.dart';
import 'package:racipi/screens/recipe_info/bloc/recipe_information_bloc.dart';
import 'package:racipi/screens/recipe_info/recipe_info.dart';
import 'package:racipi/theme/colors.dart';

class TodaysMeal extends StatelessWidget {
  final Nutrients nutrients;
  final List<MealPlan> mealPlan;
  const TodaysMeal({
    Key key,
    this.nutrients,
    this.mealPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: athens_gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text("We Have Genrated Today's \nmeal Plan for you",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ExpandableGroup(
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
              Nutritents(
                text: "Calories",
                value: nutrients.calories,
                icon: LineIcons.fire,
              ),
              Nutritents(
                text: "Carbohydrates",
                value: nutrients.carbohydrates,
                icon: Icons.bakery_dining,
              ),
              Nutritents(
                  text: "Fat", value: nutrients.fat, icon: Icons.face_outlined),
              Nutritents(
                text: "Protein",
                value: nutrients.protein,
                icon: Icons.bolt_outlined,
              ),
            ],
          ),
          ...mealPlan.map((meal) {
            return ListItemMealPlan(
              meal: meal,
            );
          }).toList()
        ],
      ),
    );
  }
}

class ListItemMealPlan extends StatefulWidget {
  final MealPlan meal;
  const ListItemMealPlan({
    Key key,
    this.meal,
  }) : super(key: key);

  @override
  _Listmealtate createState() => _Listmealtate();
}

class _Listmealtate extends State<ListItemMealPlan> {
  bool isSaved = false;
  final _base = FirebaseFirestore.instance
      .collection('Bookmarks')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('Marks');
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  _saveBookMark() async {
    await FirebaseFirestore.instance
        .collection('Bookmarks')
        .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
        .get()
        .then((value) {
      if (!value.exists) {
        value.reference.set({"Saved": []});
      }
    });
    if (!isSaved) {
      _base.doc(widget.meal.id).set({
        'id': widget.meal.id,
        'name': widget.meal.name,
        'image': widget.meal.image,
      });
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayUnion([widget.meal.id]),
      });
      setState(() {
        isSaved = true;
      });
    } else {
      _base.doc(widget.meal.id).delete();
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayRemove([widget.meal.id]),
      });
      setState(() {
        isSaved = false;
      });
    }
  }

  getInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('Bookmarks')
        .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
        .get();
    if (doc.data()['Saved'].contains(widget.meal.id)) {
      setState(() {
        isSaved = true;
      });
    } else {
      setState(() {
        isSaved = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<RecipeInformationBloc>(
            create: (context) => RecipeInformationBloc()
              ..add(LoadInformationFood(id: widget.meal.id)),
            child: RecipeInformationScreen(),
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * .33,
                  decoration: BoxDecoration(
                    color: santas_gray,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.meal.image),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .40,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.meal.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Ready in " + widget.meal.readyInMinutes + " Min",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: _saveBookMark,
                        child: Icon(
                          !isSaved
                              ? Icons.bookmark_add_outlined
                              : Icons.bookmark,
                          color: !isSaved ? Colors.black : Colors.green,
                        ))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
