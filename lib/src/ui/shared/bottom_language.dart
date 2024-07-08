import 'package:base_flutter/src/ui/shared/choose_language_dialog.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BottomLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLanguage = EasyLocalization.of(context)?.currentLocale;
    final brightness = Theme.of(context).brightness;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ChooseLamguageDialog();
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: lineColor,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'language.${currentLanguage?.countryCode?.toLowerCase()}'.tr(),
                style: AppTextStyle.regularStyle.copyWith(
                  fontSize: TextSize.superSmall,
                  color: brightness == Brightness.dark
                      ? appDark[400]
                      : appDark[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
