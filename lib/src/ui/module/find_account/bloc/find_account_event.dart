part of 'find_account_bloc.dart';

abstract class FindAccountEvent extends Equatable {
  const FindAccountEvent();

  @override
  List<Object> get props => [];
}

class FindAccountChangeEmailEvent extends FindAccountEvent {
  FindAccountChangeEmailEvent({this.email});
  final String? email;
}
