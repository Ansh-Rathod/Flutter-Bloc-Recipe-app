import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:racipi/models/search_result_model.dart';
import 'package:racipi/screens/recipe_info/bloc/recipe_information_bloc.dart';
import 'package:racipi/screens/recipe_info/recipe_info.dart';
import 'package:racipi/screens/search_results/bloc/search_results_bloc.dart';
import 'package:racipi/theme/colors.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchResultsBloc, SearchResultsState>(
      builder: (context, state) {
        if (state is SearchResultsLoading) {
          return Scaffold(
              body: Center(
                  child: SpinKitCircle(
            color: Colors.green,
            size: 50,
          )));
        } else if (state is SearchResultsSuccess) {
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
              body: SafeArea(
                  child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ...state.mealPlan.map((result) {
                    return SearchResultItem(
                      result: result,
                    );
                  }).toList()
                ],
              )));
        } else if (state is SearchResultsError) {
          return Scaffold(
              body: Container(
                  child: Center(child: Text("Something wents Wrong"))));
        } else if (state is SearchFailureState) {
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${state.error.code} Error",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Text(
                  "${state.error.message}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ));
        } else {
          return Scaffold();
        }
      },
    );
  }
}

class SearchResultItem extends StatefulWidget {
  final SearchResult result;
  const SearchResultItem({
    Key key,
    this.result,
  }) : super(key: key);

  @override
  _SearchResultresulttate createState() => _SearchResultresulttate();
}

class _SearchResultresulttate extends State<SearchResultItem> {
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
      _base.doc(widget.result.id).set({
        'id': widget.result.id,
        'name': widget.result.name,
        'image': widget.result.image,
      });
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayUnion([widget.result.id]),
      });
      setState(() {
        isSaved = true;
      });
    } else {
      _base.doc(widget.result.id).delete();
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayRemove([widget.result.id]),
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
    if (doc.data()['Saved'].contains(widget.result.id)) {
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
        Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider<RecipeInformationBloc>(
                    create: (context) => RecipeInformationBloc()
                      ..add(LoadInformationFood(id: widget.result.id)),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Container(
                          height: 230,
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 230,
                            imageUrl: widget.result.image,
                            placeholder: (context, url) => Container(
                                color: Colors.grey,
                                height: 230,
                                child: Center(
                                    child: CupertinoActivityIndicator())),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(9),
                        child: Text(
                          widget.result.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )),
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
