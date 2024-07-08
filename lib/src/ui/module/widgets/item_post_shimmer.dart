import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/animation_helper.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class ItemPostShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Material(
      borderRadius: BorderRadius.circular(
        BorderRadiusSize.postBorderRadius,
      ),
      color: brightness == Brightness.dark ? appDark[900] : appDark[50],
      child: Padding(
        padding: EdgeInsets.all(MarginSize.smallMargin2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                ).shimmerEffect,
                SizedBox(width: 8),
                Container(
                  width: 100,
                  height: 23,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(
                      BorderRadiusSize.postBorderRadius,
                    ),
                  ),
                ).shimmerEffect,
              ],
            ).addMarginBottom(MarginSize.smallMargin),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.postBorderRadius,
                ),
              ),
            ).shimmerEffect.addMarginBottom(MarginSize.smallMargin),
            Container(
              width: 100,
              height: 23,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.postBorderRadius,
                ),
              ),
            ).shimmerEffect,
          ],
        ),
      ),
    );
  }
}
