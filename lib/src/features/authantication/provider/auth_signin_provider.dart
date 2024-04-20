import 'package:enguide_app/src/features/authantication/model/concrete/auth_sign_in_model.dart';
import 'package:enguide_app/src/features/authantication/service/concrete/signin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthSigninProvider extends ChangeNotifier {
  final SignInService _signInService = SignInService();
  AuthSignInModel? authSignInModel;
  bool passwordLockBool = true;

  List<bool?> listBoolGender = [
    false,
    null
  ]; // 0 - isClick, 1 - gender(true - man,false - woman)

  //? authSignInModel instance'ini kontrollerin ardindan guncelledik, sayfa gecisinde kullanilabilir.
  updateModel(AuthSignInModel model) {
    authSignInModel = model;
    notifyListeners();
  }

  changeLock() {
    passwordLockBool = !passwordLockBool;
    notifyListeners();
  }

  clickGender({required bool value}) {
    listBoolGender[0] = true;
    listBoolGender[1] = value;
    notifyListeners();
  }

  clearGender() {
    listBoolGender = [false, null];
    notifyListeners();
  }

  //?servis baglantisi ve donus degerinin alinmasi.
  Future<AuthSignInModel?> funcPostSignIn() async {
    String baseUrl = '${dotenv.env['ENDPOINT_API_URL']}'
        '${dotenv.env['REGISTER_ROUTE']}';
    return await _signInService.postSignIn(
      url: baseUrl,
      model: authSignInModel!,
    );
  }
}
