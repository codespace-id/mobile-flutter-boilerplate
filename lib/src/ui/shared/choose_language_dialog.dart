import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChooseLamguageDialog extends StatelessWidget {
  const ChooseLamguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final supportedLocales =
        EasyLocalization.of(context)?.supportedLocales ?? [];
    final brightness = Theme.of(context).brightness;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? backgroundColor2
                : backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              'language.choose_language'
                  .tr()
                  .boldStyle(
                    fontSize: TextSize.medium,
                    color: brightness == Brightness.dark
                        ? appDark[50]
                        : appDark[800],
                  )
                  .addAllMargin(14),
              ListView.builder(
                shrinkWrap: true,
                itemCount: supportedLocales.length,
                itemBuilder: (context, index) {
                  final locale = supportedLocales[index];

                  return ListTile(
                    onTap: () {
                      context.setLocale(locale);
                      Navigator.pop(context);
                    },
                    title: Text(
                      'language.${locale.countryCode?.toLowerCase()}'.tr(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
