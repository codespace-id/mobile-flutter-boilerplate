import 'package:base_flutter/src/core/models/album_model.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ItemMyPost extends StatelessWidget {
  final AlbumModel album;
  final int index;

  const ItemMyPost({
    super.key,
    required this.index,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MarginSize.smallMargin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.profileBorderRadius,
        ),
        child: ExtendedImage.network(
          'https://picsum.photos/seed/${album.title}/200',
          cache: true,
          fit: BoxFit.cover,
          height: (index % 3 + 1) * 100,
        ),
      ),
    )
        .animate()
        .scaleXY(
          begin: 0.98,
          end: 1,
          duration: 300.ms,
        )
        .fadeIn();
  }
}
