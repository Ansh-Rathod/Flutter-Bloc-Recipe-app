import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoView extends StatelessWidget {
  final String image;

  const FullPhotoView({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: CachedNetworkImageProvider(image),
    ));
  }
}
