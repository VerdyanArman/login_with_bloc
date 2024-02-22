part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginCheckEvent extends LoginEvent {
  final String? email;
  final String? password;

  const LoginCheckEvent({this.email, this.password});
}
