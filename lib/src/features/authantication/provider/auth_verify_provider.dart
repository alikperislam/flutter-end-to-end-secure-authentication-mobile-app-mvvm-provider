import 'dart:math';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_mail_verify_model.dart';
import 'package:enguide_app/src/features/authantication/service/concrete/verify_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthVerifyProvider extends ChangeNotifier {
  final VerifyService _verifyService = VerifyService();
  bool againButtonIsClick = false;
  late String _verifyCode;
  String? _userInputCode;

  String get getVerifyCode {
    return _verifyCode;
  }

  String? get getUserInputCode {
    return _userInputCode;
  }

  void setVerifyCode(String value) {
    _verifyCode = value;
    notifyListeners();
  }

  void setUserInputCode(String value) {
    _userInputCode = value;
    notifyListeners();
  }

  randomCodeGenerator() {
    int randomVerifyCode = 100000 + Random().nextInt((999999 + 1) - 100000);
    setVerifyCode(randomVerifyCode.toString());
    notifyListeners();
  }

  //?servis baglantisi ve donus degerinin alinmasi.
  Future<int?> funcPostMail({
    required String mailAddress,
    required String verifycode,
  }) async {
    String baseUrl = '${dotenv.env['ENDPOINT_API_URL']}'
        '${dotenv.env['MAIL_VERIFY_ROUTE']}';
    return await _verifyService.postMail(
      url: baseUrl,
      model: VerifyModel(
        toMailAddress: mailAddress,
        verifyCode: verifycode,
      ),
    );
  }

  void againButtonClickEvent(bool value) {
    againButtonIsClick = value;
    notifyListeners();
  }
}
