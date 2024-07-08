part of 'find_account_bloc.dart';

class FindAccountState extends Equatable {
  const FindAccountState({
    this.isFormValid = false,
    this.email = const Email.pure(),
    this.username = const Username.pure(),
    this.emailError,
  });

  final bool isFormValid;
  final Email email;
  final Username username;
  final String? emailError;

  FindAccountState copyWith({
    bool? isFormValid,
    Email? email,
    Username? username,
    String? emailError,
  }) {
    return FindAccountState(
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
      username: username ?? this.username,
      emailError: emailError,
    );
  }

  @override
  List<Object?> get props => [
        isFormValid,
        email,
        username,
        emailError,
      ];
}
