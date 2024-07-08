import 'package:base_flutter/src/core/models/post_model.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { initial, success, failure }

class ListPostState extends Equatable {
  final List<PostModel> posts;
  final List<PostModel> stories;
  final PostStatus status;
  final int page;
  final bool hasReachedMax;

  const ListPostState({
    this.posts = const <PostModel>[],
    this.stories = const <PostModel>[],
    this.status = PostStatus.initial,
    this.page = 1,
    this.hasReachedMax = false,
  });

  ListPostState copyWith({
    List<PostModel>? posts,
    List<PostModel>? stories,
    PostStatus? status,
    int? page,
    bool? hasReachedMax,
  }) =>
      ListPostState(
        posts: posts ?? this.posts,
        stories: stories ?? this.stories,
        status: status ?? this.status,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object?> get props => [
        posts,
        stories,
        status,
        page,
        hasReachedMax,
      ];

  @override
  bool get stringify => true;
}
