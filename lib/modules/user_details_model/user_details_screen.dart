import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/isar/db.dart';
import 'package:login/modules/login_module/login.dart';
import 'package:login/shared_pref/shared_pref.dart';

import 'bloc/user_details_bloc.dart';

class UserDetails extends StatelessWidget {
  UserDetails({
    super.key,
    required this.email,
  });

  final String email;
  late UserDetailsBloc bloc;

  Future<void> logout(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );

    await SharedPref.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) {
            return bloc = UserDetailsBloc(email: email)
              ..add(const UserDetailsFetched());
          },
          child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            builder: (_, state) {
              if (state is UserDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is UserDetailsReady) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Email:'),
                                Text(state.user.email),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Age:'),
                                Text(state.user.age.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await logout(context);
                            await DB.deleteUser(email);
                          },
                          child: const Text('Delete account'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await logout(context);
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
