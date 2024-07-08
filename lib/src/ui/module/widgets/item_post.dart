import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/core/models/post_model.dart';
import 'package:base_flutter/src/ui/shared/ripple_button.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemPost extends StatelessWidget {
  ItemPost({this.post});

  final PostModel? post;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late final ValueNotifier<bool> liked = ValueNotifier(post?.isLiked ?? false);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Material(
      borderRadius: BorderRadius.circular(
        BorderRadiusSize.postBorderRadius,
      ),
      color: brightness == Brightness.dark ? appDark[900] : appDark[50],
      child: Padding(
        padding: EdgeInsets.all(MarginSize.smallMargin2),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    AssetImages.profilePic,
                    width: 34,
                    height: 34,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'David'.semiBoldStyle(
                      fontSize: TextSize.small,
                      color: brightness == Brightness.dark
                          ? appDark[200]
                          : appDark[800],
                    ),
                    '3h. Los Angeles'.semiBoldStyle(
                      fontSize: TextSize.addressTextSize,
                      color: brightness == Brightness.dark
                          ? appDark[400]
                          : appDark[800],
                    ),
                  ],
                ).addMarginLeft(MarginSize.sixPixel).addExpanded,
                RippleButton(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AssetIcons.icTrash,
                    width: IconSize.smallSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
                RippleButton(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AssetIcons.icMoreVertical,
                    width: IconSize.smallSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ).addMarginBottom(MarginSize.smallMargin),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                BorderRadiusSize.postBorderRadius,
              ),
              child: post?.url != null
                  ? ExtendedImage.file(post!.url!)
                  : ExtendedImage.network(
                      'https://picsum.photos/seed/${post?.title}/800',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      cache: true,
                    ),
            ).addMarginBottom(MarginSize.smallMargin),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable: liked,
                  builder: (context, value, _) {
                    return RippleButton(
                      onTap: () async {
                        post?.isLiked = !(post?.isLiked ?? false);
                        liked.value = post?.isLiked ?? false;
                        AnalyticsService.logEvent(
                          name: 'like_button_pressed',
                          parameters: {
                            'value': '${liked.value}',
                            'post_id': '${post?.id}',
                          },
                        );
                        const AndroidNotificationDetails
                            androidNotificationDetails =
                            AndroidNotificationDetails(
                          'like_post',
                          'Like Post',
                          importance: Importance.max,
                          priority: Priority.high,
                          ticker: 'ticker',
                        );
                        const NotificationDetails notificationDetails =
                            NotificationDetails(
                                android: androidNotificationDetails);
                        await flutterLocalNotificationsPlugin.show(
                            post?.id ?? 0,
                            'home.like_post'.tr(),
                            'home.like_your_post'.tr(),
                            notificationDetails,
                            payload: '${post?.id}');
                      },
                      child: value
                          ? SvgPicture.asset(
                              AssetIcons.icLoveGradient,
                              width: IconSize.regularSize,
                            )
                          : SvgPicture.asset(
                              AssetIcons.icLove,
                              width: IconSize.regularSize,
                              colorFilter: ColorFilter.mode(
                                  brightness == Brightness.dark
                                      ? backgroundColor
                                      : backgroundColor2,
                                  BlendMode.srcIn),
                            ),
                    );
                  },
                ),
                RippleButton(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AssetIcons.icComment,
                    width: IconSize.regularSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ).addSymmetricMargin(horizontal: 2),
                RippleButton(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AssetIcons.icSend,
                    width: IconSize.regularSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
                Container().addExpanded,
                RippleButton(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AssetIcons.icAttachment,
                    width: IconSize.regularSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().scaleXY(begin: 0.9).fadeIn();
  }
}
