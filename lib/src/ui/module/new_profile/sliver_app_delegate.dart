import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:flutter/material.dart';

const double lineHeight = 1;

class SliverAppDelegate extends SliverPersistentHeaderDelegate {
  SliverAppDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + lineHeight;
  @override
  double get maxExtent => tabBar.preferredSize.height + lineHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final brightness = Theme.of(context).brightness;
    return Container(
      color: brightness == Brightness.dark
          ? appDark[800]
          : appDark[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tabBar,
          Container(
            width: double.infinity,
            height: lineHeight,
            margin: EdgeInsets.symmetric(horizontal: 24),
            color: lineColor,
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverAppDelegate oldDelegate) {
    return false;
  }
}
