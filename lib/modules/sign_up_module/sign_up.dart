import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/login_module/login.dart';
import 'package:login/modules/user_details_model/user_details_screen.dart';

import '../../widgets/custom_text_field.dart';
import 'block/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  void _goToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const LoginScreen();
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
    String? age;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create an account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: BlocProvider(
          create: (context) => SignUpBloc(),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.canNavigate) {
                _login(context, email!);
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Age',
                      errorMessage: state.ageError,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        age = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            _goToLoginPage(context);
                          },
                          child: const Text('Already have an account'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<SignUpBloc>().add(
                                  SignUpCheckEvent(
                                    password: password,
                                    email: email,
                                    age: age,
                                  ),
                                );
                          },
                          child: const Text('Save'),
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
