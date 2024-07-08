import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/find_account/bloc/find_account_bloc.dart';
import 'package:base_flutter/src/ui/shared/base_common_textinput.dart';
import 'package:base_flutter/src/ui/shared/bottom_language.dart';
import 'package:base_flutter/src/ui/shared/primary_button.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FindAccountScreen extends StatefulWidget {
  static const String routeName = 'find-account';
  FindAccountScreen({super.key});

  @override
  State<FindAccountScreen> createState() => _FindAccountScreenState();
}

class _FindAccountScreenState extends State<FindAccountScreen> {
  final textFieldController = TextEditingController();
  late final FindAccountBloc _bloc = FindAccountBloc();

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: FindAccountScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SafeStatusBar(
      statusBarColor: Colors.white,
      lightIcon: brightness == Brightness.dark ? false : true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo().addMarginOnly(
                  top: 24,
                  bottom: 50,
                ),
                _buildDescription().addMarginBottom(
                  MarginSize.smallMargin,
                ),
                _buildEmailTextField().addSymmetricMargin(
                  horizontal: MarginSize.defaultMargin,
                ),
                _buildFindButton(),
                _buildOr().addMarginOnly(
                  left: MarginSize.defaultMargin,
                  right: MarginSize.defaultMargin,
                  bottom: MarginSize.mediumMargin,
                ),
                _buildGoogleFacebook(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomLanguage(),
      ),
    );
  }

  Widget _buildOr() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: lineColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: Text(
            'find_account.or'.tr(),
            style: AppTextStyle.semiBoldStyle.copyWith(
              fontSize: TextSize.superSmall,
              color: lineColor,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: lineColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFindButton() {
    return BlocBuilder<FindAccountBloc, FindAccountState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.email != current.email,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MarginSize.defaultMargin,
            vertical: MarginSize.smallMargin3,
          ),
          width: double.infinity,
          child: SizedBox(
            height: 42,
            child: PrimaryButton(
              onPress: () {},
              isEnabled: state.isFormValid,
              title: 'find_account.find'.tr(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmailTextField() {
    return BlocBuilder<FindAccountBloc, FindAccountState>(
      bloc: _bloc,
      buildWhen: (prev, current) => prev.email != current.email,
      builder: (context, state) {
        return BaseCommonTextInput(
          label: "find_account.hint".tr(),
          textFieldController: textFieldController,
          error: state.emailError,
          onChanged: (value) => _bloc.add(
            FindAccountChangeEmailEvent(
              email: value,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        "find_account.title"
            .tr()
            .mediumStyle(fontSize: TextSize.semiLarge)
            .addMarginBottom(4),
        Text(
          "find_account.sub_title".tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.mediumStyle.copyWith(
            fontSize: TextSize.superSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      AssetImages.logo,
      width: 152,
    );
  }

  Widget _buildGoogleFacebook() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MarginSize.defaultMargin),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(AssetIcons.icGoogle),
              ),
            ),
            SizedBox(width: 24),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(AssetIcons.icFacebook),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
