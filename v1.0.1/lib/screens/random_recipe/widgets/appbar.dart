import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipia/screens/random_recipe/widgets/favorite_button.dart';
import 'package:share/share.dart';
import '../../../animation/animation.dart';

import '../../../models/racipe.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Recipe info;
  MySliverAppBar({
    required this.expandedHeight,
    required this.info,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = maxExtent - shrinkOffset;
    final proportion = 2 - (maxExtent / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: maxExtent),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Positioned(
              child: Container(
            color: Colors.white,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Stack(
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Positioned(
                    child: CachedNetworkImage(
                      imageUrl: info.image!,
                      height: 270,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )),
          AppBarWidget(
            expandedHeight: expandedHeight,
            shrinkOffset: shrinkOffset,
            info: info,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Opacity(
                opacity: (1 - shrinkOffset / expandedHeight),
                child: DelayedDisplay(
                  delay: const Duration(microseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "${info.spoonacularScore}",
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.star_outlined,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                      FavoriteButton(info: info)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: maxExtent,
      );
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    required this.expandedHeight,
    required this.shrinkOffset,
    required this.info,
  }) : super(key: key);

  final double expandedHeight;
  final double shrinkOffset;
  final Recipe info;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  Future<Uri> data() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://newapp2222.page.link/',
      link: Uri.parse(
          'https://ansh-rathod-blog.netlify.app/?id=${widget.info.id}'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.android',
        minimumVersion: 125,
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: widget.info.title,
        description: widget.info.summary,
        imageUrl: Uri.parse(widget.info.image!),
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      dynamicUrl,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );

    final Uri shortUrl = shortenedLink.shortUrl;
    return shortUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            // padding: EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final url = await data();
            Share.share(
              'check out This tasty recipe $url',
            );
          },
          icon: const Icon(CupertinoIcons.share, color: Colors.black),
        )
      ],
      title: Opacity(
        opacity: (0 + widget.shrinkOffset / widget.expandedHeight),
        child: Text(
          "Spoonacular",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
