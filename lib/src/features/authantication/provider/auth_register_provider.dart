import 'package:enguide_app/src/core/init/cache/auth/cache_operations.dart';
import 'package:enguide_app/src/core/init/cache/auth/splash_token_hive.dart';
import 'package:flutter/material.dart';

class AuthRegisterProvider extends ChangeNotifier {
  bool page = false;
  bool verify = false;

  //? kayit - giris sayfalari arasi gecis
  changePage({required bool value}) {
    page = value;
    notifyListeners();
  }

  changeVerify({required bool value}) {
    verify = value;
    notifyListeners();
  }

  readTokenToCache() async {
    CacheOperations cache = CacheOperations();
    SplashTokenHiveDb? tokenValue = await cache.readUser();
    notifyListeners();
    return tokenValue?.token ?? '';
  }

  readNameToCache() async {
    CacheOperations cache = CacheOperations();
    SplashTokenHiveDb? nameValue = await cache.readUser();
    notifyListeners();
    return nameValue?.name ?? '';
  }

  addUserToCache({required String token, required String name}) {
    CacheOperations cache = CacheOperations();
    cache.addUser(SplashTokenHiveDb(token: token, name: name));
    notifyListeners();
  }

  deleteUserToCache() {
    CacheOperations cache = CacheOperations();
    cache.deleteUser();
    notifyListeners();
  }
}
