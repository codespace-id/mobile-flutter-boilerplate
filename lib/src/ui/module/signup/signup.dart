import 'package:base_flutter/src/ui/module/signup/signup_bloc.dart';
import 'package:base_flutter/src/ui/module/signup/signup_event.dart';
import 'package:base_flutter/src/ui/module/signup/signup_state.dart';
import 'package:base_flutter/src/ui/module/signup_password/signup_password.dart';
import 'package:base_flutter/src/ui/shared/app_title.dart';
import 'package:base_flutter/src/ui/shared/base_common_textinput.dart';
import 'package:base_flutter/src/ui/shared/bottom_language.dart';
import 'package:base_flutter/src/ui/shared/primary_button.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController textControllerUserName = TextEditingController();

  late SignupBloc _bloc;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: SignUpScreen.routeName);
    _bloc = context.read<SignupBloc>();
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
              SizedBox(height: 51),
              _chooseUserName(brightness),
              SizedBox(height: 3),
              _chooseLater(brightness),
              SizedBox(height: 22),
              _inputUsername(),
              SizedBox(height: 16),
              _buildButton(),
            ],
          ),
        ),
        bottomNavigationBar: BottomLanguage(),
      ),
    );
  }

  Widget _chooseUserName(Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: Text(
        'signup.choose_username'.tr(),
        style: AppTextStyle.mediumStyle.copyWith(
          fontSize: 20,
          color: brightness == Brightness.dark ? appDark[50] : appDark[800],
        ),
      ),
    );
  }

  Widget _chooseLater(Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: Text(
        'signup.change_later'.tr(),
        style: AppTextStyle.mediumStyle.copyWith(
          fontSize: TextSize.superSmall,
          color: brightness == Brightness.dark ? appDark[400] : lineColor,
        ),
      ),
    );
  }

  Widget _inputUsername() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MarginSize.defaultMargin,
      ),
      child: BlocBuilder<SignupBloc, SignupState>(
        bloc: _bloc,
        buildWhen: (prev, current) => prev.username != current.username,
        builder: (context, state) => BaseCommonTextInput(
          textFieldController: textControllerUserName,
          label: 'Username',
          onChanged: (value) => _bloc.add(
            SignupChangeUsernameEvent(
              username: value,
            ),
          ),
          error: state.usernameError,
        ),
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
        child: BlocBuilder<SignupBloc, SignupState>(
          bloc: _bloc,
          buildWhen: (prev, current) => prev.isFormValid != current.isFormValid,
          builder: (context, state) => PrimaryButton(
            onPress: () {
              Navigator.pushNamed(context, SignUpPasswordScreen.routeName);
            },
            title: 'signup.next'.tr(),
            isEnabled: state.isFormValid,
          ),
        ),
      ),
    );
  }
}
