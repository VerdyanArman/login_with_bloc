import 'package:isar/isar.dart';

part 'users.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  late String username;
  late String password;
  late int age;

  @override
  String toString() {
    return username;
  }
}
