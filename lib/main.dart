import 'package:flutter/material.dart';
import 'package:login/isar/db.dart';
import 'package:login/modules/login_module/login.dart';
import 'package:login/modules/user_details_model/user_details_screen.dart';
import 'package:login/shared_pref/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.initialize();
  await DB.fetchUsers();

  String? email = await SharedPref.getUser();

  runApp(MyApp(email: email));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(email: email),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.email == null) {
      return const LoginScreen();
    }

    return UserDetails(email: widget.email!);
  }
}
