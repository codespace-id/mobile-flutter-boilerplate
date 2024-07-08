import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/new_profile/new_profile_bloc.dart';
import 'package:base_flutter/src/ui/module/new_profile/new_profile_event.dart';
import 'package:base_flutter/src/ui/module/new_profile/new_profile_state.dart';
import 'package:base_flutter/src/ui/module/new_profile/sliver_app_delegate.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_followers.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts.dart';
import 'package:base_flutter/src/ui/module/new_profile/widgets/content_collapse.dart';
import 'package:base_flutter/src/ui/module/new_profile/widgets/item_statistic.dart';
import 'package:base_flutter/src/ui/module/setting/setting.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/animation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double appBarHeight = 168;
const double expandedHeight = 348;

class NewProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewProfileState();
  }
}

class _NewProfileState extends State<NewProfile>
    with SingleTickerProviderStateMixin {
  final _bloc = NewProfileBloc();
  late final _tabController = TabController(
    length: 3,
    vsync: this,
  );
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreens(name: 'new-profile');
    AnalyticsService.logScreens(name: 'tab-profile-post');
    _bloc.add(NewProfileAppBarEvent(isCollapsed: false));
    _tabController.addListener(_onTabChangeListener);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final scrolled = constraints.scrollOffset > appBarHeight;
                    debugPrint('NewProfile # collapsed $scrolled');
                    _bloc.add(NewProfileAppBarEvent(isCollapsed: scrolled));
                    return SliverAppBar(
                      forceElevated: true,
                      backgroundColor: brightness == Brightness.dark
                          ? appDark[900]
                          : appDark[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            BorderRadiusSize.profileBorderRadius,
                          ),
                          bottomRight: Radius.circular(
                            BorderRadiusSize.profileBorderRadius,
                          ),
                        ),
                      ),
                      pinned: true,
                      elevation: 5,
                      collapsedHeight: appBarHeight,
                      expandedHeight: expandedHeight,
                      leadingWidth: 150,
                      leading: _profileName(brightness),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Setting.routeName);
                          },
                          child: Icon(
                            Icons.menu_rounded,
                            color: brightness == Brightness.dark
                                ? appDark[200]
                                : appDark[800],
                          ),
                        ),
                        SizedBox(width: 24),
                      ],
                      flexibleSpace: _contentExpanded(brightness),
                    );
                  },
                ),
                SliverPersistentHeader(
                  delegate: SliverAppDelegate(
                    tabBar: TabBar(
                      controller: _tabController,
                      labelColor: primary,
                      unselectedLabelColor: brightness == Brightness.dark
                          ? textColor2
                          : textColor,
                      labelStyle: AppTextStyle.boldStyle
                          .copyWith(fontSize: TextSize.small),
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Text('Posts'),
                        ),
                        Tab(
                          child: Text('Followers'),
                        ),
                        Tab(
                          child: Text('Followings'),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                TabProfilePosts(),
                TabProfileFollowers(),
                TabProfileFollowers(),
              ],
            ),
          ),
          BlocBuilder<NewProfileBloc, NewProfileState>(
            bloc: _bloc,
            buildWhen: (prev, current) =>
                prev.isCollapsed != current.isCollapsed,
            builder: (context, state) {
              if (state.isCollapsed) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: appBarHeight + 14,
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 60),
                        ContentCollapse().fadeInEffect,
                        _line(),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void _onTabChangeListener() {
    switch (_tabController.index) {
      case 0:
        AnalyticsService.logScreens(name: 'tab-profile-post');
        break;
      case 1:
        AnalyticsService.logScreens(name: 'tab-profile-followers');
        break;
      case 2:
        AnalyticsService.logScreens(name: 'tab-profile-followings');
        break;
    }
  }

  Widget _profileName(Brightness brightness) {
    return Container(
      color: brightness == Brightness.dark ? appDark[900] : appDark[50],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 24),
          Text(
            'David William',
            style: AppTextStyle.semiBoldStyle.copyWith(
              color:
                  brightness == Brightness.dark ? appDark[200] : appDark[800],
              fontSize: 11,
            ),
          ),
          SizedBox(width: 4),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color:
                  brightness == Brightness.dark ? appDark[200] : appDark[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentExpanded(Brightness brightness) {
    return FlexibleSpaceBar(
      background: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 80),
          _avatar(),
          SizedBox(height: 11),
          _personalInfo(brightness),
          SizedBox(height: 17),
          _statistic(),
          SizedBox(height: 20),
          _line(),
          SizedBox(height: 7),
        ],
      ),
    );
  }

  Widget _avatar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 90,
          width: 90,
          child: Stack(
            children: [
              Image.asset(
                AssetImages.profilePic,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryGradient,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _personalInfo(Brightness brightness) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'David William',
              style: AppTextStyle.boldStyle.copyWith(
                color:
                    brightness == Brightness.dark ? appDark[200] : appDark[800],
                fontSize: TextSize.semiLarge,
              ),
            ),
            SizedBox(width: 12),
            Icon(
              Icons.edit_outlined,
              color:
                  brightness == Brightness.dark ? appDark[200] : appDark[800],
            ),
          ],
        ),
        SizedBox(height: 11),
        Text(
          'Lifestyle | UIux Designer | Model',
          style: AppTextStyle.regularStyle.copyWith(
            color: brightness == Brightness.dark ? appDark[200] : appDark[800],
            fontSize: TextSize.superSmall,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'david.william@gmail.com',
          style: AppTextStyle.regularStyle.copyWith(
            color: brightness == Brightness.dark ? appDark[200] : appDark[800],
            fontSize: TextSize.superSmall,
          ),
        ),
        SizedBox(height: 13),
        Text(
          'davidwilliam.com',
          style: AppTextStyle.regularStyle.copyWith(
            color: Colors.blue,
            fontSize: TextSize.superSmall,
          ),
        ),
      ],
    );
  }

  Widget _statistic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ItemStatistic(count: 33, name: 'Posts'),
        ItemStatistic(count: 743, name: 'Followers'),
        ItemStatistic(count: 1034, name: 'Followings'),
      ],
    );
  }

  Widget _line() {
    return Center(
      child: Container(
        width: 41,
        height: 4,
        decoration: BoxDecoration(
          color: primaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }

}
