import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentCollapse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 72,
          width: 72,
          child: Stack(
            children: [
              Image.asset(
                AssetImages.profilePic,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: primaryGradient,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ).addMarginRight(MarginSize.profileMargin),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                'David William'
                    .boldStyle(
                      fontSize: TextSize.medium,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    )
                    .addMarginRight(10),
                SvgPicture.asset(
                  AssetIcons.icEdit,
                  width: IconSize.smallSize,
                  colorFilter: ColorFilter.mode(
                      brightness == Brightness.dark
                          ? backgroundColor
                          : backgroundColor2,
                      BlendMode.srcIn),
                ),
              ],
            ).addMarginBottom(MarginSize.smallMargin),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    '33'.semiBoldStyle(
                      fontSize: TextSize.medium,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    ),
                    'Posts'.semiBoldStyle(
                      fontSize: TextSize.profileTitle,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    '743'.semiBoldStyle(
                      fontSize: TextSize.medium,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    ),
                    'Followers'.semiBoldStyle(
                      fontSize: TextSize.profileTitle,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    )
                  ],
                ).addSymmetricMargin(horizontal: 56),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    '1,043'.semiBoldStyle(
                      fontSize: TextSize.medium,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    ),
                    'Following'.semiBoldStyle(
                      fontSize: TextSize.profileTitle,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
