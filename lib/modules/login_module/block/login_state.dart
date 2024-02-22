part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final bool canNavigate;

  const LoginState({
    this.emailError,
    this.passwordError,
    this.canNavigate = false,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? canNavigate,
  }) {
    if (canNavigate == true) {
      return const LoginState(
        emailError: null,
        passwordError: null,
        canNavigate: true,
      );
    }

    if (emailError == '') {
      return LoginState(
        emailError: null,
        passwordError: passwordError ?? this.passwordError,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    if (passwordError == '') {
      return LoginState(
        emailError: emailError ?? this.emailError,
        passwordError: null,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      canNavigate: canNavigate ?? this.canNavigate,
    );
  }

  @override
  List<Object?> get props => [emailError, passwordError, canNavigate];
}
