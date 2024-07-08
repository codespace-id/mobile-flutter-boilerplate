import 'package:equatable/equatable.dart';

abstract class ListExploreEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListExploreInitEvent extends ListExploreEvent {}

class ListExploreRefreshEvent extends ListExploreEvent {}
