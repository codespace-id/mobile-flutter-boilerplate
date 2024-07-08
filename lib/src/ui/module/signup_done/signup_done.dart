import 'package:base_flutter/src/ui/module/home/home.dart';
import 'package:base_flutter/src/ui/shared/app_title.dart';
import 'package:base_flutter/src/ui/shared/bottom_language.dart';
import 'package:base_flutter/src/ui/shared/primary_button.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpDoneScreen extends StatefulWidget {
  static const String routeName = 'signup_done';
  @override
  State<StatefulWidget> createState() {
    return _SignUpDoneScreenState();
  }
}

class _SignUpDoneScreenState extends State<SignUpDoneScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: SignUpDoneScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 15),
              Center(
                child: AppTitle(fontSize: 64),
              ),
              SizedBox(height: 99),
              _welcome(brightness),
              SizedBox(height: 23),
              _buildButton(),
              SizedBox(height: 17),
              _completeRegister(brightness),
            ],
          ),
        ),
        bottomNavigationBar: BottomLanguage(),
      ),
    );
  }

  Widget _welcome(Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: Column(
        children: [
          Text(
            'signup.welcome'.tr(),
            style: AppTextStyle.mediumStyle.copyWith(
              fontSize: TextSize.semiLarge,
              color: brightness == Brightness.dark ? appDark[50] : appDark[800],
            ),
          ),
          Text(
            'david.william',
            style: AppTextStyle.mediumStyle.copyWith(
              fontSize: TextSize.semiLarge,
              color: brightness == Brightness.dark ? appDark[400] : lineColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 42,
        child: PrimaryButton(
          onPress: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Home.routeName,
              ModalRoute.withName('/'),
            );
          },
          title: 'signup.complete_signup'.tr(),
        ),
      ),
    );
  }

  Widget _completeRegister(Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: Text(
        'signup.add_phone_email'.tr(),
        style: AppTextStyle.semiBoldStyle.copyWith(
          fontSize: 10,
          color: brightness == Brightness.dark ? appDark[50] : appDark[800],
        ),
      ),
    );
  }
}
