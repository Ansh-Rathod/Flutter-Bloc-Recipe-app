import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racipi/models/type_model.dart';
import 'package:racipi/screens/recipe_info/bloc/recipe_information_bloc.dart';
import 'package:racipi/screens/recipe_info/recipe_info.dart';

class FoodTypeWidget extends StatelessWidget {
  final List<FoodType> items;

  const FoodTypeWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 330,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          // store this controller in a State to save the carousel scroll position
          children: [
            SizedBox(width: 10),
            ...items.map((item) {
              return RecipeCardType(items: item);
            }).toList()
          ],
        ));
  }
}

class RecipeCardType extends StatefulWidget {
  const RecipeCardType({
    Key key,
    @required this.items,
  }) : super(key: key);

  final FoodType items;

  @override
  _RecipeCardTypeState createState() => _RecipeCardTypeState();
}

class _RecipeCardTypeState extends State<RecipeCardType> {
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
      _base.doc(widget.items.id).set({
        'id': widget.items.id,
        'name': widget.items.name,
        'image': widget.items.image,
      });
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayUnion([widget.items.id]),
      });
      setState(() {
        isSaved = true;
      });
    } else {
      _base.doc(widget.items.id).delete();
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayRemove([widget.items.id]),
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
    if (doc.data()['Saved'].contains(widget.items.id)) {
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
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider<RecipeInformationBloc>(
                create: (context) => RecipeInformationBloc()
                  ..add(LoadInformationFood(id: widget.items.id)),
                child: RecipeInformationScreen(),
              ),
            ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(8),
              width: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      height: 190,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      width: double.infinity,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 190,
                        imageUrl: widget.items.image,
                        placeholder: (context, url) => Container(
                            color: Colors.grey,
                            height: 190,
                            child: Center(child: CupertinoActivityIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(9),
                    child: Text(
                      widget.items.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      "Ready in " + widget.items.readyInMinutes + " Min",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 30,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _saveBookMark,
                child: Icon(
                  !isSaved ? Icons.bookmark_add_outlined : Icons.bookmark,
                  color: !isSaved ? Colors.black : Colors.green,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
