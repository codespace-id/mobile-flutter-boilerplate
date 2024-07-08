import 'dart:async';

import 'package:base_flutter/src/core/models/album_model.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore_bloc.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore_event.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore_state.dart';
import 'package:base_flutter/src/ui/module/widgets/item_album.dart';
import 'package:base_flutter/src/ui/module/widgets/item_load_more.dart';
import 'package:base_flutter/src/ui/shared/base_common_textinput.dart';
import 'package:base_flutter/src/ui/shared/safe_statusbar.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/sizes.dart';
import 'package:base_flutter/src/utils/widget_helper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListExlore extends StatefulWidget {
  @override
  State<ListExlore> createState() => _ListExloreState();
}

class _ListExloreState extends State<ListExlore> {
  final TextEditingController _searchController = TextEditingController();

  final _scrollController = ScrollController();
  final slideIndex = ValueNotifier(0);
  late ListExploreBloc _bloc;

  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = ListExploreBloc();
    _bloc.add(ListExploreInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SafeStatusBar(
      lightIcon: brightness == Brightness.dark ? true : false,
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            BlocBuilder<ListExploreBloc, ListExploreState>(
              bloc: _bloc,
              buildWhen: (previous, current) {
                return previous.status != current.status ||
                    previous.albums != current.albums ||
                    previous.hasReachedMax != current.hasReachedMax ||
                    previous.page != current.page;
              },
              builder: (context, state) {
                if (state.status == AlbumStatus.initial) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Expanded(child: _buildGrid(state));
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

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: BaseCommonTextInput(
        textFieldController: _searchController,
        backgroundColor: Colors.white,
        borderRadius: BorderRadiusSize.searchBarRadius,
        customBorderColor: Colors.black.withOpacity(0.05),
        focusBorderColor: Colors.black.withOpacity(0.05),
        label: 'Search',
        onChanged: (p0) {
          debouncer?.cancel();
          debouncer = Timer(800.ms, () {
            _bloc.add(ListExploreRefreshEvent());
            debouncer?.cancel();
          });
        },
      ),
    );
  }

  Widget _buildGrid(ListExploreState state) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(ListExploreRefreshEvent());
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        child: StaggeredGrid.count(
          crossAxisCount: 3,
          axisDirection: AxisDirection.down,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 2,
              child: _buildSlide(state),
            ),
            for (AlbumModel model in state.albums)
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: ItemAlbum(model),
              ),
            if (!state.hasReachedMax)
              StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 1,
                child: ItemLoadMore(),
              ),
          ],
        ),
      ),
    );
  }

  Stack _buildSlide(ListExploreState state) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: 3,
          onPageChanged: (value) => slideIndex.value = value,
          itemBuilder: (context, index) {
            final album = state.albums[index];
            return Padding(
              padding: EdgeInsets.all(6),
              child: Stack(
                children: [
                  ExtendedImage.network(
                    'https://picsum.photos/seed/${album.title}/800',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    cache: true,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(
            valueListenable: slideIndex,
            builder: (context, index, _) {
              return AnimatedSmoothIndicator(
                activeIndex: index,
                effect: WormEffect(
                  dotWidth: 6,
                  dotHeight: 6,
                  dotColor: lineColor,
                  activeDotColor: Colors.white,
                ),
                count: 3,
              ).addMarginBottom(14);
            },
          ),
        )
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(ListExploreInitEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
