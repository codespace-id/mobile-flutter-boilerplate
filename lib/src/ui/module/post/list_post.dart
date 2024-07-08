import 'package:base_flutter/r.dart';
import 'package:base_flutter/src/ui/module/post/list_post_bloc.dart';
import 'package:base_flutter/src/ui/module/post/list_post_event.dart';
import 'package:base_flutter/src/ui/module/post/list_post_state.dart';
import 'package:base_flutter/src/ui/module/widgets/item_load_more.dart';
import 'package:base_flutter/src/ui/module/widgets/item_post.dart';
import 'package:base_flutter/src/ui/module/widgets/item_post_shimmer.dart';
import 'package:base_flutter/src/ui/module/widgets/item_stories_shimmer.dart';
import 'package:base_flutter/src/ui/shared/ripple_button.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListPost extends StatefulWidget {
  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  // final TextEditingController _searchController = TextEditingController();

  final _scrollController = ScrollController();
  late ListPostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = context.read<ListPostBloc>();
    _bloc.add(ListPostInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    AssetIcons.icCircle,
                    width: IconSize.defaultSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
              ),
              Expanded(
                  child: SvgPicture.asset(
                AssetImages.logo,
                height: 44,
              )),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    AssetIcons.icChat,
                    width: IconSize.defaultSize,
                    colorFilter: ColorFilter.mode(
                        brightness == Brightness.dark
                            ? backgroundColor
                            : backgroundColor2,
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ListPostBloc, ListPostState>(
              bloc: _bloc,
              buildWhen: (previous, current) {
                return previous.status != current.status ||
                    previous.posts != current.posts ||
                    previous.hasReachedMax != current.hasReachedMax ||
                    previous.page != current.page;
              },
              builder: (context, state) {
                if (state.status == PostStatus.initial) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            index == 0 ? _buildStoriesShimmer() : const SizedBox(),
                            ItemPostShimmer()
                                .addMarginBottom(22)
                                .addSymmetricMargin(horizontal: 14),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: _buildList(state),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Widget _buildList(ListPostState state) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(ListPostRefreshEvent());
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount:
            state.hasReachedMax ? state.posts.length : state.posts.length + 1,
        itemBuilder: (context, index) {
          return index >= state.posts.length
              ? ItemLoadMore()
              : Column(
                  children: [
                    index == 0 ? _buildStories() : const SizedBox(),
                    ItemPost(
                      post: state.posts[index],
                    ).addMarginBottom(22).addSymmetricMargin(horizontal: 14),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildStories() {
    return Container(
        height: 62,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10, bottom: 18),
        child: BlocBuilder<ListPostBloc, ListPostState>(
          bloc: _bloc,
          buildWhen: (previous, current) {
            return previous.status != current.status ||
                previous.stories != current.stories ||
                previous.hasReachedMax != current.hasReachedMax ||
                previous.page != current.page;
          },
          builder: (context, state) {
            return ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: state.posts.length,
              padding: EdgeInsets.only(left: 10),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    _buildItemStories(index, state.stories[index].title ?? '')
                        .animate(
                          delay: (10 * index).ms,
                        )
                        .slideX(begin: 0.4, end: 0, duration: 300.ms)
                        .scaleXY(begin: 0.9)
                        .fadeIn(),
                    index == 0
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: SvgPicture.asset(
                                AssetIcons.icAddCircle,
                                height: 19,
                              ),
                            ),
                          )
                            .animate(
                              delay: (50 * index).ms,
                            )
                            .slideX(begin: 0.4, end: 0, duration: 300.ms)
                            .scaleXY(begin: 0.9)
                            .fadeIn()
                        : SizedBox(),
                  ],
                );
              },
            );
          },
        ));
  }

  Widget _buildItemStories(int index, String image) {
    return RippleButton(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Container(
        height: 58,
        width: 58,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: index == 0 ? linearGradientDisabled : linearGradient,
          shape: BoxShape.circle,
        ),
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 100,
          backgroundImage: ExtendedNetworkImageProvider(
            'https://picsum.photos/seed/$image/200',
            cache: true,
          ),
        ),
      ),
    );
  }

  Widget _buildStoriesShimmer() {
    return Container(
      width: double.infinity,
      height: 62,
      margin: EdgeInsets.only(top: 10, bottom: 18),
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ItemStoriesShimmer();
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(ListPostInitEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
