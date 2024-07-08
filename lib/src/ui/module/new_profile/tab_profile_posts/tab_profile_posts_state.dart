import 'package:base_flutter/src/core/models/post_model.dart';
import 'package:equatable/equatable.dart';

enum ProfilePostStatus { initial, success, failure }

class TabProfilePostState extends Equatable {
  final List<PostModel> posts;
  final ProfilePostStatus status;
  final int page;
  final bool hasReachedMax;

  const TabProfilePostState({
    this.posts = const <PostModel>[],
    this.status = ProfilePostStatus.initial,
    this.page = 1,
    this.hasReachedMax = false,
  });

  TabProfilePostState copyWith({
    List<PostModel>? posts,
    ProfilePostStatus? status,
    int? page,
    bool? hasReachedMax,
  }) =>
      TabProfilePostState(
        posts: posts ?? this.posts,
        status: status ?? this.status,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object?> get props => [
    posts,
    status,
    page,
    hasReachedMax,
  ];

  @override
  bool get stringify => true;
}
