import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racipi/screens/recipe_info/bloc/recipe_information_bloc.dart';
import 'package:racipi/screens/recipe_info/recipe_info.dart';
import 'package:racipi/theme/colors.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Spoonacular",
          style: GoogleFonts.lobster(
              textStyle: TextStyle(color: Colors.green, fontSize: 20)),
        ),
      ),
      backgroundColor: athens_gray,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Bookmarks')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('Marks')
              .snapshots(),
          builder:
              // ignore: missing_return
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: snapshot.data.docs.map((document) {
                  return ListItemMealPlan(
                    meal: document,
                  );
                }).toList(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                  child: SpinKitCircle(
                color: Colors.green,
                size: 50,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error"));
            }
          }),
    );
  }
}

class ListItemMealPlan extends StatefulWidget {
  final meal;
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

  _saveBookMark() {
    FirebaseFirestore.instance
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
                      image: NetworkImage(widget.meal['image']),
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
                            widget.meal['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
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
