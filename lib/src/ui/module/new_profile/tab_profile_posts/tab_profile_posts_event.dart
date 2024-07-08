import 'package:equatable/equatable.dart';

abstract class TabProfilePostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabProfilePostsInitEvent extends TabProfilePostsEvent {}

class TabProfilePostsRefreshEvent extends TabProfilePostsEvent {}
