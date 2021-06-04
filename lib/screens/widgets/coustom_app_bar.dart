import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:racipi/models/recipe.dart';

import 'photo_view.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String image;
  final String title;
  final Recipe recipe;
  MySliverAppBar(this.image, this.title, this.recipe,
      {@required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: FullPhotoView(
            image: image,
          ),
          withNavBar: false, // OPTIONAL VALUE. True b
        );
      },
      child: Container(
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            Positioned(
              child: Container(
                color: Colors.grey[200],
                child: Opacity(
                  opacity: (1 - shrinkOffset / expandedHeight),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image == null
                                ? "https://spoonacular.com/recipeImages/${recipe.id}-556x370.${recipe.imageType == null ? "jpg" : recipe.imageType}"
                                : image),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            AppBarWidget(
              expandedHeight: expandedHeight,
              title: title,
              shrinkOffset: shrinkOffset,
              recipe: recipe,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key key,
    @required this.expandedHeight,
    @required this.title,
    this.shrinkOffset,
    this.recipe,
  }) : super(key: key);

  final double expandedHeight;
  final String title;
  final Recipe recipe;
  final double shrinkOffset;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
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
      _base.doc(widget.recipe.id.toString()).set({
        'id': widget.recipe.id,
        'name': widget.recipe.title,
        'image': widget.recipe.image,
      });
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayUnion([widget.recipe.id]),
      });
      if (mounted) {
        setState(() {
          isSaved = true;
        });
      }
    } else {
      _base.doc(widget.recipe.id.toString()).delete();
      FirebaseFirestore.instance
          .collection('Bookmarks')
          .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
          .update({
        "Saved": FieldValue.arrayRemove([widget.recipe.id]),
      });
      if (mounted) {
        setState(() {
          isSaved = false;
        });
      }
    }
  }

  getInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('Bookmarks')
        .doc("Diary-${FirebaseAuth.instance.currentUser.uid}")
        .get();
    if (doc.data()['Saved'].contains(widget.recipe.id)) {
      if (mounted) {
        setState(() {
          isSaved = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isSaved = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            // padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _saveBookMark,
                child: Icon(
                  !isSaved ? Icons.bookmark_add_outlined : Icons.bookmark,
                  color: !isSaved ? Colors.black : Colors.green,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
      title: Opacity(
        opacity: (0 + widget.shrinkOffset / widget.expandedHeight),
        child: Text(
          widget.title,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
    );
  }
}
