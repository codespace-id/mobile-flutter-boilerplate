import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class ItemStatistic extends StatelessWidget {
  ItemStatistic({
    this.count = 0,
    this.name = "",
  });

  final int count;
  final String name;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: AppTextStyle.semiBoldStyle.copyWith(
            fontSize: TextSize.superLarge,
            color: brightness == Brightness.dark ? appDark[200] : appDark[800],
          ),
        ),
        Text(
          name,
          style: AppTextStyle.semiBoldStyle.copyWith(
            color: brightness == Brightness.dark ? appDark[500] : appDark[800],
            fontSize: TextSize.superSmall,
          ),
        ),
      ],
    );
  }
}
