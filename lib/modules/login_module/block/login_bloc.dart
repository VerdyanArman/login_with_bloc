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

    final numbers = RegExp(r'[0-9]');
    final small = RegExp(r'[a-z]');
    final big = RegExp(r'[A-Z]');
    final symbols = RegExp(r'\W');

    if (email == null || email.isEmpty) {
      emitter(state.copyWith(emailError: 'Email is required'));
      return;
    }

    final emailRegex = RegExp(r'(\w+@+\w+\.+\w)');

    if (!emailRegex.hasMatch(email)) {
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

    //password validation

    if (!numbers.hasMatch(password)) {
      emitter(state.copyWith(
        passwordError: 'Password required to have numbers',
      ));
      return;
    }

    if (!small.hasMatch(password)) {
      emitter(state.copyWith(
        passwordError: 'Password required to have small letter',
      ));
      return;
    }

    if (!big.hasMatch(password)) {
      emitter(state.copyWith(
        passwordError: 'Password required to have big letter',
      ));
      return;
    }

    if (password.length < 9) {
      emitter(state.copyWith(passwordError: 'Weak Password'));
      return;
    }

    if (password.length < 12 && !symbols.hasMatch(password)) {
      emitter(state.copyWith(passwordError: 'Weak Password'));
      return;
    }

    emitter(state.copyWith(passwordError: ''));

    //Password Security

    if (password.length < 12 && symbols.hasMatch(password)) {
      emitter(state.copyWith(passwordSecurity: 'Medium'));
      return;
    }

    if (password.length >= 12 && !symbols.hasMatch(password)) {
      emitter(state.copyWith(passwordSecurity: 'Medium'));
      return;
    }

    emitter(state.copyWith(passwordSecurity: 'Strong'));

    if (!DB.checkPassword(email, password)) {
      emitter(state.copyWith(passwordError: 'Wrong Password'));
      return;
    }

    await SharedPref.saveUser(email);

    emitter(state.copyWith(canNavigate: true));
  }
}
