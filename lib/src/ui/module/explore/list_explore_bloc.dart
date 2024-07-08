import 'package:base_flutter/src/core/networks/network_helper.dart';
import 'package:base_flutter/src/core/repositories/api/photo_repository.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore_event.dart';
import 'package:base_flutter/src/ui/module/explore/list_explore_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListExploreBloc extends Bloc<ListExploreEvent, ListExploreState> {
  PhotoRepository? _repository;

  ListExploreBloc() : super(const ListExploreState()) {
    _repository = PhotoRepository(NetworkHelper());
    on<ListExploreInitEvent>(
      _onInit,
      transformer: throttleDroppable(
        throttleDuration,
      ),
    );
    on<ListExploreRefreshEvent>(_onRefresh);
  }

  void _onInit(
      ListExploreInitEvent event, Emitter<ListExploreState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == AlbumStatus.initial) {
        final response = await _repository?.getListAlbum(state.page);
        final albums = response?.data?.listAlbum ?? [];
        emit(state.copyWith(
          status: AlbumStatus.success,
          albums: albums,
          hasReachedMax: false,
        ));
      }
      int nextPage = state.page + 1;
      emit(state.copyWith(
        page: nextPage,
      ));
      final response = await _repository?.getListAlbum(state.page);
      final albums = response?.data?.listAlbum ?? [];
      if (albums.isEmpty) {
        emit(state.copyWith(
          status: AlbumStatus.success,
          hasReachedMax: true,
        ));
      } else {
        emit(state.copyWith(
          status: AlbumStatus.success,
          albums: List.of(state.albums)..addAll(albums),
          hasReachedMax: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AlbumStatus.failure,
      ));
    }
  }

  void _onRefresh(
      ListExploreRefreshEvent event, Emitter<ListExploreState> emit) {
    emit(state.copyWith(
      status: AlbumStatus.initial,
      page: 1,
      hasReachedMax: false,
      albums: [],
    ));
    add(ListExploreInitEvent());
  }
}
