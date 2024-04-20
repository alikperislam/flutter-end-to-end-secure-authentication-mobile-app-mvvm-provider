import 'dart:convert';
import 'package:enguide_app/src/core/errors/auth/auth_errors.dart';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_log_in_model.dart';
import 'package:enguide_app/src/features/authantication/service/abstract/i_login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LogInService implements ILogInService {
  @override
  Future<AuthLogInModel?> postLogIn({
    required String url,
    required AuthLogInModel model,
  }) async {
    try {
      //
      final uri = Uri.parse(url);
      var postData = AuthLogInModel().toJson(authLogInModel: model);
      var response = await http.post(uri, body: postData);
      final statusCode = response.statusCode;
      //
      if (response.statusCode == 200) {
        //? headers
        final token = response.headers[dotenv.env['SIGN_IN_HEADERS']];
        //? body
        final jsonBody = jsonDecode(response.body);
        //? json value
        final modelJson = AuthLogInModel.fromJson(jsonBody, token!, statusCode);
        return modelJson;
      } else {
        //! servis hatasi bilgisi.
        final modelJson = AuthLogInModel.fromJsonOnlyStatusCode(statusCode);
        return modelJson;
      }
    }
    //
    catch (e) {
      AuthErrorModel errorModel = AuthErrorModel("Error message: $e");
      debugPrint(errorModel.getErrorFunction);
      //! servis hatasi bilgisi.
      return null;
    }
  }
}
