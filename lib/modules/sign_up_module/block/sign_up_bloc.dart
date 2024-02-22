import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login/shared_pref/shared_pref.dart';

import '../../../isar/db.dart';
import '../../../isar/users.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<SignUpCheckEvent>(_check);
  }

  void _check(SignUpCheckEvent event, Emitter emitter) async {
    final email = event.email;
    final password = event.password;
    final age = event.age;

    if (email == null || email.isEmpty) {
      emitter(state.copyWith(emailError: 'Email is required'));
      return;
    }

    final exp = RegExp(r'(\w+@+\w+\.+\w)');

    if (!exp.hasMatch(email)) {
      emitter(state.copyWith(emailError: 'Please write correct email'));
      return;
    }

    if (DB.checkEmail(email)) {
      emitter(state.copyWith(emailError: 'Email already exist'));
      return;
    }

    emitter(state.copyWith(emailError: ''));

    if (password == null || password.isEmpty) {
      emitter(state.copyWith(passwordError: 'Password is required'));
      return;
    }

    emitter(state.copyWith(passwordError: ''));

    if (age == null || age.isEmpty) {
      emitter(state.copyWith(ageError: 'Age is required'));
      return;
    }

    if (int.tryParse(age) == null) {
      emitter(state.copyWith(ageError: 'Please input an integer'));
      return;
    }

    int ageNumber = int.tryParse(age) as int;

    if (ageNumber <= 0) {
      emitter(state.copyWith(ageError: 'Please write correct age'));
      return;
    }

    User user = User();
    user.password = password;
    user.age = ageNumber;
    user.username = email;

    await DB.addUser(user);

    await SharedPref.saveUser(email);

    emitter(state.copyWith(canNavigate: true));
  }
}
