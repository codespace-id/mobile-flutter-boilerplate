import 'package:base_flutter/src/ui/module/new_profile/widgets/item_follow.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:flutter/material.dart';

class TabProfileFollowers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(MarginSize.profileMargin),
      itemBuilder: (context, index) => ItemFollow(),
      separatorBuilder: (context, index) => SizedBox(height: 4),
      itemCount: 10,
    );
  }
}
