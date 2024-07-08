import 'package:base_flutter/src/ui/module/new_profile/new_profile_event.dart';
import 'package:base_flutter/src/ui/module/new_profile/new_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProfileBloc extends Bloc<NewProfileEvent, NewProfileState> {
  NewProfileBloc() : super(NewProfileState()) {
    on<NewProfileAppBarEvent>(_onShowAppBar);
  }

  void _onShowAppBar(
    NewProfileAppBarEvent event,
    Emitter<NewProfileState> emit,
  ) {
    emit(state.copyWith(
      isCollapsed: event.isCollapsed,
    ));
  }
}
