import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/login/login.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AnalyticsService.logScreens(name: 'Splash');
    final brightness = Theme.of(context).brightness;
    _delay(context);
    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(
            AssetImages.logo,
            width: MediaQuery.of(context).size.width * 0.6,
          )
              .animate()
              .slideY(begin: 0.1, end: 0, duration: 600.ms)
              .fadeIn()
              .then()
              .animate(delay: 1.4.seconds)
              .scaleXY(end: 0, curve: Curves.elasticIn),
        ),
      ),
    );
  }

  void _delay(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 2), () {
      // Always check if the widget is mounted in async function that require context
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          ModalRoute.withName('/'),
        );
      }
    });
  }
}
