import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore.dart';
import 'package:base_flutter/src/ui/module/new_profile/new_profile.dart';
import 'package:base_flutter/src/ui/module/post/list_post.dart';
import 'package:base_flutter/src/ui/module/post/list_post_bloc.dart';
import 'package:base_flutter/src/ui/module/post/list_post_event.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/analytics_service.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/take_picture.dart';

class Home extends StatefulWidget {
  static const String routeName = 'home';
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> menu = <Widget>[
    ListPost(),
    ListExlore(),
    SizedBox(),
    ListExlore(),
    NewProfile(),
  ];
  late ListPostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ListPostBloc>();
    AnalyticsService.logScreens(name: Home.routeName);
    AnalyticsService.logScreens(name: 'list-post');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: menu.map((t) => Center(child: t)).toList(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    final brightness = Theme.of(context).brightness;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(BorderRadiusSize.bottomNavRadius),
        topRight: Radius.circular(BorderRadiusSize.bottomNavRadius),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.icHome,
              colorFilter: _selectedIndex == 0
                  ? ColorFilter.mode(primary, BlendMode.srcIn)
                  : ColorFilter.mode(
                      brightness == Brightness.dark
                          ? backgroundColor
                          : backgroundColor2,
                      BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.icExplore,
              colorFilter: _selectedIndex == 1
                  ? ColorFilter.mode(primary, BlendMode.srcIn)
                  : ColorFilter.mode(
                      brightness == Brightness.dark
                          ? backgroundColor
                          : backgroundColor2,
                      BlendMode.srcIn),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetIcons.icAddCircle),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetIcons.icLove,
              colorFilter: _selectedIndex == 3
                  ? ColorFilter.mode(primary, BlendMode.srcIn)
                  : ColorFilter.mode(
                      brightness == Brightness.dark
                          ? backgroundColor
                          : backgroundColor2,
                      BlendMode.srcIn),
            ),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                gradient: _selectedIndex == 4 ? linearGradient : null,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  AssetImages.profilePic,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ).addAllPadding(2),
            ),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }

  void _onItemTap(int index) {
    String tabName = '';
    switch (index) {
      case 0:
        AnalyticsService.logScreens(name: 'list-post');
        tabName = 'list_post';
        break;
      case 1:
        AnalyticsService.logScreens(name: 'list-explore');
        tabName = 'list_explore';
        break;
      case 2:
        AnalyticsService.logScreens(name: 'create-post');
        tabName = 'create_post';
        break;
      case 3:
        AnalyticsService.logScreens(name: 'notification');
        tabName = 'notification';
        break;
      case 4:
        AnalyticsService.logScreens(name: 'profile');
        tabName = 'profile';
        break;
    }
    AnalyticsService.logEvent(
      name: 'tab_icon_pressed',
      parameters: {
        'tab_name': tabName,
      },
    );
    if (index == 2) {
      AnalyticsService.logScreens(name: 'create-post');
      tabName = 'create_post';
      TakePicture(
        context: context,
        onSuccess: (val) {
          if (val != null) {
            _bloc.add(ListPostUploadImageEvent(val));
            // call Refresh event if use real API
            // _bloc.add(ListPostRefreshEvent());
          }
        },
      ).take();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
