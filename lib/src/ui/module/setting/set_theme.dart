import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/shared/my_app_toolbar.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/ui/styles/theme_manager/theme_manager.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetTheme extends StatefulWidget {
  static const String routeName = 'set_theme';
  const SetTheme({super.key});

  @override
  State<SetTheme> createState() => _SetThemeState();
}

class _SetThemeState extends State<SetTheme> {
  int? selectedIndex;
  List<Map<String, String>> themeMode = [
    {
      'mode': 'Light',
      'icon': AssetIcons.icLight,
    },
    {
      'mode': 'Dark',
      'icon': AssetIcons.icDark,
    },
    {
      'mode': 'System Default',
      'icon': AssetIcons.icDefaultMobile,
    },
  ];

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: SetTheme.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    ThemeManager theme = BlocProvider.of<ThemeManager>(context, listen: true);
    if (theme.themeMode == ThemeMode.light) {
      selectedIndex = 0;
    } else if (theme.themeMode == ThemeMode.dark) {
      selectedIndex = 1;
    } else if (theme.themeMode == ThemeMode.system) {
      selectedIndex = 2;
    }
    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        appBar: MyAppToolbar(
          title: 'Set Theme',
          onTap: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _buildItemMode(
                      themeMode[index]['mode'] ?? '',
                      index,
                      themeMode[index]['icon'] ?? '',
                      theme,
                      brightness,
                    ),
                    itemCount: themeMode.length,
                  ),
                  SizedBox(height: 10),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildItemMode(String title, int index, String icon,
      ThemeManager theme, Brightness brightness) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          theme.changeTheme(ThemeMode.light);
        } else if (index == 1) {
          theme.changeTheme(ThemeMode.dark);
        } else if (index == 2) {
          theme.changeTheme(ThemeMode.system);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              SizedBox(width: 6),
              Text(
                title,
                style: AppTextStyle.mediumStyle.copyWith(
                  fontSize: 20,
                  color: brightness == Brightness.dark
                      ? appDark[50]
                      : appDark[800],
                ),
              ),
            ],
          ),
          Container(
            height: 11,
            width: 11,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == index ? primary : backgroundColor,
                border: Border.all(color: textColor, width: 1)),
          )
        ],
      ).addSymmetricPadding(vertical: 10, horizontal: 27),
    );
  }
}
