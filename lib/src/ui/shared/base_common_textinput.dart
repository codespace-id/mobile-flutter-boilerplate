import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseCommonTextInput extends StatelessWidget {
  final TextEditingController textFieldController;
  final String label;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final Function(String)? onChanged;
  final String? error;
  final double? borderRadius;
  final Color? customBorderColor;
  final Color? focusBorderColor;
  final bool showBorder;
  final bool showIcon;

  const BaseCommonTextInput({
    required this.textFieldController,
    required this.label,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
    this.backgroundColor,
    this.error,
    this.borderRadius,
    this.customBorderColor,
    this.focusBorderColor,
    this.showBorder = true,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: textInputType == TextInputType.visiblePassword,
      textInputAction: textInputAction ?? TextInputAction.done,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: showIcon
            ? Container(
                padding: EdgeInsets.all(PaddingSize.searchFieldMargin),
                child: SvgPicture.asset(
                  AssetIcons.icSearch,
                ),
              )
            : null,
        errorText: error,
        hintText: label,
        fillColor: backgroundColor ?? textFieldBackgroundColor,
        hintStyle: TextStyle(
          color: textTintColor,
          fontSize: TextSize.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          borderSide: showBorder
              ? BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: customBorderColor ?? borderColor,
                )
              : BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          borderSide: showBorder
              ? BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: customBorderColor ?? borderColor,
                )
              : BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          borderSide: showBorder
              ? BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: focusBorderColor ?? primary,
                )
              : BorderSide(color: Colors.transparent),
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
      ),
      style: TextStyle(
        fontSize: TextSize.regular,
        color: textColor,
      ),
      controller: textFieldController,
    );
  }
}
