import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../isar/db.dart';
import '../../../shared_pref/shared_pref.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginCheckEvent>(_check);
  }

  void _check(LoginCheckEvent event, Emitter emitter) async {
    final email = event.email;
    final password = event.password;

    if (email == null || email.isEmpty) {
      emitter(state.copyWith(emailError: 'Email is required'));
      return;
    }

    final exp = RegExp(r'(\w+@+\w+\.+\w)');

    if (!exp.hasMatch(email)) {
      emitter(state.copyWith(emailError: 'Please write correct email'));
      return;
    }

    if (!DB.checkEmail(email)) {
      emitter(state.copyWith(emailError: 'Email dose not exist'));
      return;
    }

    emitter(state.copyWith(emailError: ''));

    if (password == null || password.isEmpty) {
      emitter(state.copyWith(passwordError: 'Password is required'));
      return;
    }

    if (!DB.checkPassword(email, password)) {
      emitter(state.copyWith(passwordError: 'Wrong Password'));
      return;
    }

    await SharedPref.saveUser(email);

    emitter(state.copyWith(canNavigate: true));
  }
}
