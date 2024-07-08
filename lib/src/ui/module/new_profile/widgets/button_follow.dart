import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class ButtonFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: linearGradient,
        borderRadius: BorderRadius.circular(
          BorderSize.largeBorder,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 16,
            ),
            Text(
              'Following',
              style: AppTextStyle.semiBoldStyle.copyWith(
                color: Colors.white,
                fontSize: TextSize.superSmall,
              ),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              BorderSize.largeBorder,
            ),
          ),
        ),
      ),
    );
  }
}
