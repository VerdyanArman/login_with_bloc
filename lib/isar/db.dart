import 'package:isar/isar.dart';
import 'package:login/isar/users.dart';
import 'package:login/user_model.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static late Isar _isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
  }

  static final List<User> users = [];

  static Future<void> addUser(User user) async {
    await _isar.writeTxn(
      () => _isar.users.put(user),
    );

    await fetchUsers();
  }

  static bool checkEmail(String email) {
    for (final user in users) {
      if (email == user.username) {
        return true;
      }
    }

    return false;
  }

  static bool checkPassword(String email, String password) {
    for (final user in users) {
      if (email == user.username && password == user.password) {
        return true;
      }
    }

    return false;
  }

  static Future<UserModel> getUser(String email) async {
    await fetchUsers();

    late final UserModel currentUser;

    for (final user in users) {
      if (email == user.username) {
        currentUser = UserModel(age: user.age, email: email);
        break;
      }
    }

    return currentUser;
  }

  static Future<void> fetchUsers() async {
    List<User> fetchedUsers = await _isar.users.where().findAll();

    users.clear();
    users.addAll(fetchedUsers);
  }

  static Future<void> updateUsers(int id, User user) async {
    final existingUser = await _isar.users.get(id);
    if (existingUser != null) {
      existingUser.password = user.password;
      existingUser.age = user.age;
      existingUser.username = user.username;

      await _isar.writeTxn(() => _isar.users.put(existingUser));
      await fetchUsers();
    }
  }

  static Future<void> deleteUser(String email) async {
    await fetchUsers();

    final user = _isar.users.filter().usernameEqualTo(email);

    final id = await user.idProperty().findFirst();

    if (id != null) {
      await _isar.writeTxn(() => _isar.users.delete(id));
      await fetchUsers();
    }
  }
}
