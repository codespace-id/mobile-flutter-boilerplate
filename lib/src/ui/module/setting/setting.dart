import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/setting/set_theme.dart';
import 'package:base_flutter/src/ui/module/widgets/item_setting.dart';
import 'package:base_flutter/src/ui/shared/base_common_textinput.dart';
import 'package:base_flutter/src/ui/shared/choose_language_dialog.dart';
import 'package:base_flutter/src/ui/shared/my_app_toolbar.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  static const String routeName = 'settings';
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: Setting.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        appBar: MyAppToolbar(title: 'Setting'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildItemSetting(),
                  _buildLogins(brightness),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return BaseCommonTextInput(
      textFieldController: _searchController,
      backgroundColor: searchBarColor2,
      borderRadius: BorderRadiusSize.searchBarRadius,
      customBorderColor: Colors.black.withOpacity(0.05),
      focusBorderColor: Colors.black.withOpacity(0.05),
      label: 'Search',
      onChanged: (p0) {},
    ).addMarginBottom(10).addSymmetricPadding(horizontal: 15);
  }

  Widget _buildItemSetting() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ItemSetting(
          icon: AssetIcons.icUserGroup,
          label: 'setting.follow_invite_friends',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icNotification,
          label: 'setting.notification',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icLock,
          label: 'setting.privacy',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icSecurity,
          label: 'setting.security',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icAds,
          label: 'setting.ads',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icAccount,
          label: 'setting.account',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icHelp,
          label: 'setting.help',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icAbout,
          label: 'setting.about',
          onTap: () {},
        ),
        ItemSetting(
          icon: AssetIcons.icTheme,
          label: 'setting.theme',
          onTap: () {
            Navigator.pushNamed(
              context,
              SetTheme.routeName,
            );
          },
        ),
        ItemSetting(
          icon: AssetIcons.icTranslate,
          label: 'setting.language',
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ChooseLamguageDialog();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLogins(Brightness brightness) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Logins",
          style: AppTextStyle.semiBoldStyle.copyWith(
            fontSize: 20,
            color: brightness == Brightness.dark ? appDark[50] : appDark[800],
          ),
        ).addMarginBottom(10),
        InkWell(
          onTap: () {},
          child: 'setting.add_or_switch_account'.tr().regularStyle(
                fontSize: TextSize.small,
                color: primary,
              ),
        ).addMarginBottom(16).addSymmetricPadding(horizontal: 14),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Text(
                'setting.logout'.tr() + " David William",
                style: AppTextStyle.regularStyle.copyWith(
                  fontSize: TextSize.small,
                  color: primary,
                ),
              )
            ],
          ),
        ).addMarginBottom(16).addSymmetricPadding(horizontal: 14),
        InkWell(
          onTap: () {},
          child: 'setting.logout_all_account'.tr().regularStyle(
                fontSize: TextSize.small,
                color: primary,
              ),
        ).addMarginBottom(16).addSymmetricPadding(horizontal: 14),
      ],
    ).addMarginTop(22).addSymmetricPadding(horizontal: 15);
  }
}
