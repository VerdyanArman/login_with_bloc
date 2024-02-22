part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String? emailError;
  final String? passwordError;
  final String? ageError;
  final bool canNavigate;

  const SignUpState({
    this.ageError,
    this.emailError,
    this.passwordError,
    this.canNavigate = false,
  });

  SignUpState copyWith({
    String? emailError,
    String? passwordError,
    String? ageError,
    bool? canNavigate,
  }) {
    if (canNavigate == true) {
      return const SignUpState(
        emailError: null,
        passwordError: null,
        ageError: null,
        canNavigate: true,
      );
    }

    if (emailError == '') {
      return SignUpState(
        emailError: null,
        ageError: ageError ?? this.ageError,
        passwordError: passwordError ?? this.passwordError,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    if (passwordError == '') {
      return SignUpState(
        emailError: emailError ?? this.emailError,
        ageError: ageError ?? this.ageError,
        passwordError: null,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    if (ageError == '') {
      return SignUpState(
        emailError: emailError ?? this.emailError,
        ageError: null,
        passwordError: null,
        canNavigate: canNavigate ?? this.canNavigate,
      );
    }

    return SignUpState(
      emailError: emailError ?? this.emailError,
      ageError: ageError ?? this.ageError,
      passwordError: passwordError ?? this.passwordError,
      canNavigate: canNavigate ?? this.canNavigate,
    );
  }

  @override
  List<Object?> get props => [emailError, passwordError, ageError, canNavigate];
}
