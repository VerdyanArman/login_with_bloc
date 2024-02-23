part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final bool canNavigate;
  final String? passwordSecurity;

  const LoginState({
    this.emailError,
    this.passwordError,
    this.canNavigate = false,
    this.passwordSecurity,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? canNavigate,
    String? passwordSecurity,
  }) {
    if (canNavigate == true) {
      return LoginState(
        emailError: null,
        passwordError: null,
        canNavigate: true,
        passwordSecurity: passwordSecurity ?? this.passwordSecurity,
      );
    }

    if (emailError == '') {
      return LoginState(
        emailError: null,
        passwordError: passwordError ?? this.passwordError,
        canNavigate: canNavigate ?? this.canNavigate,
        passwordSecurity: passwordSecurity ?? this.passwordSecurity,
      );
    }

    if (passwordError == '') {
      return LoginState(
        emailError: emailError ?? this.emailError,
        passwordError: null,
        passwordSecurity: passwordSecurity ?? this.passwordSecurity,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      canNavigate: canNavigate ?? this.canNavigate,
      passwordSecurity: passwordSecurity ?? this.passwordSecurity,
    );
  }

  @override
  List<Object?> get props => [
        emailError,
        passwordError,
        canNavigate,
        passwordSecurity,
      ];
}
