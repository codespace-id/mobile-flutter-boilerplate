import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppToolbar extends StatelessWidget implements PreferredSizeWidget {
  MyAppToolbar({this.title, this.onTap});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                // padding: EdgeInsets.zero,
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  AssetIcons.icBackAndroid,
                  height: 10,
                  colorFilter: ColorFilter.mode(
                    brightness == Brightness.dark
                        ? backgroundColor
                        : backgroundColor2,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                title ?? '',
                style: AppTextStyle.boldStyle.copyWith(
                  color: brightness == Brightness.dark ? textColor2 : textColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: lineColor,
          ).addMarginTop(10)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
