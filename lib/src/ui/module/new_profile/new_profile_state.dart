import 'package:equatable/equatable.dart';

class NewProfileState extends Equatable {
  NewProfileState({
    this.isCollapsed = false,
  });

  final bool isCollapsed;

  NewProfileState copyWith({
    bool? isCollapsed,
  }) {
    return NewProfileState(
      isCollapsed: isCollapsed ?? this.isCollapsed,
    );
  }

  @override
  List<Object?> get props => [
        isCollapsed,
      ];
}
