import 'package:enguide_app/src/core/init/cache/auth/splash_token_hive.dart';
import 'package:hive/hive.dart';

class CacheOperations {
  readUser() async {
    var box = await Hive.openBox('TokenStorage');
    return box.get('user');
  }

  void addUser(SplashTokenHiveDb db) async {
    var box = await Hive.openBox('TokenStorage');
    box.put('user', db);
  }

  void deleteUser() async {
    var box = await Hive.openBox('TokenStorage');
    box.delete('user');
  }
}
