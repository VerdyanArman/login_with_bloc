part of 'sign_up_bloc.dart';

sealed class SignUpEvent {
  const SignUpEvent();
}

final class SignUpCheckEvent extends SignUpEvent {
  final String? email;
  final String? password;
  final String? age;

  const SignUpCheckEvent({this.email, this.password, this.age});
}
