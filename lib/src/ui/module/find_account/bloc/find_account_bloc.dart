import 'package:base_flutter/src/utils/validations/email_validation.dart';
import 'package:base_flutter/src/utils/validations/username_validation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'find_account_event.dart';
part 'find_account_state.dart';

class FindAccountBloc extends Bloc<FindAccountEvent, FindAccountState> {
  FindAccountBloc() : super(FindAccountState()) {
    on<FindAccountChangeEmailEvent>(_onEmailChanged);
  }

  void _onEmailChanged(
    FindAccountChangeEmailEvent event,
    Emitter<FindAccountState> emit,
  ) {
    final email = Email.dirty(event.email ?? '');
    final username = Username.dirty(event.email ?? '');

    emit(state.copyWith(
      email: email,
      username: username,
      emailError: email.error,
    ));
    _validateInput(emit);
  }

  void _validateInput(
    Emitter<FindAccountState> emit,
  ) {
    emit(state.copyWith(
      isFormValid: state.email.isValid || state.username.isValid,
    ));
  }
}
