import 'package:equatable/equatable.dart';

abstract class NewProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewProfileAppBarEvent extends NewProfileEvent {
  NewProfileAppBarEvent({required this.isCollapsed});
  final bool isCollapsed;
  @override
  List<Object?> get props => [isCollapsed];
}