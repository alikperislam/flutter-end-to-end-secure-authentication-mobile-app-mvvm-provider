// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'package:enguide_app/src/core/errors/auth/auth_errors.dart';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_sign_in_model.dart';
import 'package:enguide_app/src/features/authantication/service/abstract/i_signin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SignInService implements ISignInService {
  @override
  Future<AuthSignInModel?> postSignIn({
    required String url,
    required AuthSignInModel model,
  }) async {
    try {
      //
      final uri = Uri.parse(url);
      var postData = AuthSignInModel().toJson(authSignInModel: model);
      var response = await http.post(uri, body: postData);
      //
      if (response.statusCode == 200) {
        //? headers
        final token = await DataEncrypt.wrappingDecrypted(
          response.headers[dotenv.env['SIGN_IN_HEADERS']],
        );
        //? body
        final jsonBody = jsonDecode(response.body);
        //? json value
        final modelJson = AuthSignInModel.fromJson(jsonBody, token!);
        return modelJson;
      } else {
        //! servis hatasi bilgisi.
        return null;
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
