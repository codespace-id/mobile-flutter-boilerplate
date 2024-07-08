import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'status_bar.dart';

class SafeStatusBar extends StatelessWidget {
  final bool lightIcon;
  final Color? statusBarColor;
  final Widget child;

  const SafeStatusBar({
    Key? key,
    this.lightIcon = true,
    this.statusBarColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return StatusBar(
      lightIcon: lightIcon,
      child: Container(
        color: statusBarColor == null
            ? brightness == Brightness.dark
                ? backgroundColor2
                : backgroundColor
            : Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
