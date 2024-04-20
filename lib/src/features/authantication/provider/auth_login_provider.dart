import 'package:enguide_app/src/features/authantication/model/concrete/auth_log_in_model.dart';
import 'package:enguide_app/src/features/authantication/service/concrete/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthLoginProvider extends ChangeNotifier {
  final LogInService _logInService = LogInService();
  AuthLogInModel? authLogInModel;
  bool passwordLockBool = true;

  //? login page password textfield lock - unlock function
  changeLock() {
    passwordLockBool = !passwordLockBool;
    notifyListeners();
  }

  //? logInModel instance'ini kontrollerin ardindan guncelledik, sayfa gecisinde kullanilabilir.
  updateModel(AuthLogInModel model) {
    authLogInModel = model;
    notifyListeners();
  }

  //?servis baglantisi ve donus degerinin alinmasi.
  Future<AuthLogInModel?> funcPostLogIn() async {
    String baseUrl = '${dotenv.env['ENDPOINT_API_URL']}'
        '${dotenv.env['LOGIN_ROUTE']}';
    return await _logInService.postLogIn(
      url: baseUrl,
      model: authLogInModel!,
    );
  }
}
