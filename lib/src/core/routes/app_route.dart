import 'package:base_flutter/src/ui/module/find_account/find_account.dart';
import 'package:base_flutter/src/ui/module/home/home.dart';
import 'package:base_flutter/src/ui/module/login/login.dart';
import 'package:base_flutter/src/ui/module/login/login_bloc.dart';
import 'package:base_flutter/src/ui/module/post/list_post_bloc.dart';
import 'package:base_flutter/src/ui/module/setting/set_theme.dart';
import 'package:base_flutter/src/ui/module/setting/setting.dart';
import 'package:base_flutter/src/ui/module/signup/signup.dart';
import 'package:base_flutter/src/ui/module/signup/signup_bloc.dart';
import 'package:base_flutter/src/ui/module/signup_done/signup_done.dart';
import 'package:base_flutter/src/ui/module/signup_password/signup_password.dart';
import 'package:base_flutter/src/ui/module/signup_password/signup_password_bloc.dart';
import 'package:base_flutter/src/ui/module/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) => Splash(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginScreen(),
          ),
        );
      case FindAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => FindAccountScreen(),
          // builder: (BuildContext context) => BlocProvider(
          //   create: (context) => LoginBloc(),
          //   child: FindAccountScreen(),
          // ),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => SignupBloc(),
            child: SignUpScreen(),
          ),
        );
      case SignUpPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => SignupPasswordBloc(),
            child: SignUpPasswordScreen(),
          ),
        );
      case SignUpDoneScreen.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => SignUpDoneScreen(),
        );
      case Home.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ListPostBloc(),
            child: Home(),
          ),
        );
      case Setting.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => Setting(),
        );
      case SetTheme.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => SetTheme(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text(
                'Page Not Found',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
    }
  }
}
