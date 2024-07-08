import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/new_profile/widgets/button_follow.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class ItemFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusSize.profileBorderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 34,
                  height: 34,
                  child: Image.asset(AssetImages.profilePic),
                ),
                SizedBox(width: 6),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shaikh Ayesha',
                      style: AppTextStyle.semiBoldStyle.copyWith(
                        fontSize: 11,
                        color: brightness == Brightness.dark
                            ? appDark[200]
                            : appDark[800],
                      ),
                    ),
                    Text(
                      'Friends since 26 march 2023',
                      style: AppTextStyle.semiBoldStyle.copyWith(
                        color: brightness == Brightness.dark
                            ? appDark[400]
                            : appDark[800],
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 100,
              height: 25,
              child: ButtonFollow(),
            ),
          ],
        ),
      ),
    );
  }
}
