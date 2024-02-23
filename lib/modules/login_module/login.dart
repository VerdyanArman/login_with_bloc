// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/sign_up_module/sign_up.dart';
import 'package:login/modules/user_details_model/user_details_screen.dart';

import '../../widgets/custom_text_field.dart';
import 'block/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  void goToSignUpPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const SignUpScreen();
        },
      ),
    );
  }

  void _login(BuildContext context, String email) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) {
          return UserDetails(email: email);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.canNavigate) {
                _login(context, email!);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Login'),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Email',
                      errorMessage: state.emailError,
                      keyboardType: TextInputType.emailAddress,
                      onChange: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Password',
                      errorMessage: state.passwordError,
                      obscureText: true,
                      onChange: (value) {
                        password = value;
                      },
                    ),
                    if (state.passwordSecurity != null)
                      Text(
                        state.passwordSecurity!,
                      ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            goToSignUpPage(context);
                          },
                          child: const Text('Register an account'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  LoginCheckEvent(
                                    password: password,
                                    email: email,
                                  ),
                                );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
