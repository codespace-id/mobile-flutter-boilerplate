import 'package:base_flutter/src/utils/animation_helper.dart';
import 'package:flutter/material.dart';

class ItemStoriesShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 58,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        shape: BoxShape.circle,
      ),
    ).shimmerEffect;
  }

}