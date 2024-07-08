import 'package:base_flutter/src/core/models/album_model.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ItemAlbum extends StatelessWidget {
  const ItemAlbum(this.album);

  final AlbumModel? album;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MarginSize.sixPixel),
      child: Stack(
        children: [
          ExtendedImage.network(
            'https://picsum.photos/seed/${album?.title}/200',
            cache: true,
          ),
        ],
      ),
    )
        .animate(target: 1)
        .scaleXY(begin: 0.96, end: 1, duration: 300.ms)
        .fadeIn();
  }
}
