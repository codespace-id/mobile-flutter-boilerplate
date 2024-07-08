import 'package:base_flutter/src/core/networks/network_helper.dart';
import 'package:base_flutter/src/core/repositories/api/post_repository.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts_event.dart';
import 'package:base_flutter/src/ui/module/new_profile/tab_profile_posts/tab_profile_posts_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TabProfilePostsBloc extends Bloc<TabProfilePostsEvent, TabProfilePostState> {
  PostRepository? _repository;

  TabProfilePostsBloc() : super(const TabProfilePostState()) {
    _repository = PostRepository(NetworkHelper());
    on<TabProfilePostsInitEvent>(
      _onInit,
      transformer: throttleDroppable(throttleDuration),
    );
    on<TabProfilePostsRefreshEvent>(_onRefresh);
  }

  void _onInit(
    TabProfilePostsInitEvent event,
    Emitter<TabProfilePostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProfilePostStatus.initial) {
        final response = await _repository?.getListPost(state.page);
        final posts = response?.data?.listPost ?? [];
        emit(state.copyWith(
          status: ProfilePostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      int nextPage = state.page + 1;
      emit(state.copyWith(
        page: nextPage,
      ));
      final response = await _repository?.getListPost(state.page);
      final posts = response?.data?.listPost ?? [];
      if (posts.isEmpty) {
        emit(state.copyWith(
          status: ProfilePostStatus.success,
          hasReachedMax: true,
        ));
      } else {
        emit(state.copyWith(
          status: ProfilePostStatus.success,
          hasReachedMax: false,
          posts: List.of(state.posts)..addAll(posts),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProfilePostStatus.failure,
      ));
    }
  }

  void _onRefresh(
    TabProfilePostsRefreshEvent event,
    Emitter<TabProfilePostState> emit,
  ) {
    emit(state.copyWith(
      status: ProfilePostStatus.initial,
      page: 1,
      hasReachedMax: false,
      posts: [],
    ));
    add(TabProfilePostsInitEvent());
  }
}
