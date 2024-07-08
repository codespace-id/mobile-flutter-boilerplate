import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts_bloc.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts_event.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts_state.dart';
import 'package:base_flutter/src/ui/module/widgets/item_load_more.dart';
import 'package:base_flutter/src/ui/module/widgets/item_post.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabProfilePosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabProfilePostsState();
  }
}

class _TabProfilePostsState extends State<TabProfilePosts> {
  final _bloc = TabProfilePostsBloc();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _bloc.add(TabProfilePostsInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(TabProfilePostsRefreshEvent());
      },
      child: BlocBuilder<TabProfilePostsBloc, TabProfilePostState>(
        bloc: _bloc,
        buildWhen: (prev, current) {
          return prev.status != current.status ||
              prev.posts != current.posts ||
              prev.hasReachedMax != current.hasReachedMax ||
              prev.page != current.page;
        },
        builder: (context, state) {
          if (state.status == ProfilePostStatus.initial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            itemBuilder: (context, index) {
              return index >= state.posts.length
                  ? ItemLoadMore()
                  : ItemPost(
                      post: state.posts[index],
                    ).addMarginBottom(22).addSymmetricMargin(horizontal: 14);
            },
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(TabProfilePostsInitEvent());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
