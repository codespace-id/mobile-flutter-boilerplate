import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';

class ItemSetting extends StatelessWidget {
  ItemSetting({required this.icon, this.label, this.onTap});

  final String icon;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            height: IconSize.smallSize,
            colorFilter: ColorFilter.mode(
                brightness == Brightness.dark
                    ? backgroundColor
                    : backgroundColor2,
                BlendMode.srcIn),
          ),
          SizedBox(width: 10),
          '$label'.tr().mediumStyle(
                fontSize: 20,
                color:
                    brightness == Brightness.dark ? appDark[50] : appDark[800],
              ),
        ],
      ).addSymmetricPadding(vertical: 10, horizontal: 27),
    );
  }
}
