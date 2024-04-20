// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'package:enguide_app/src/core/encrypt/data_encrypt.dart';
import 'package:enguide_app/src/core/errors/auth/auth_errors.dart';
import 'package:enguide_app/src/features/authantication/model/concrete/auth_mail_verify_model.dart';
import 'package:enguide_app/src/features/authantication/service/abstract/i_verify_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyService implements IVerifyService {
  @override
  Future<int?> postMail({
    required String url,
    required VerifyModel model,
  }) async {
    try {
      //
      final uri = Uri.parse(url);
      var postData = VerifyModel().toJson(verifyModel: model);
      var response = await http.post(uri, body: postData);
      //
      if (response.statusCode == 200) {
        //! servise baglanildi bilgisi.
        final jsonBody =
            jsonDecode(DataEncrypt.wrappingDecrypted(response.body));
        final modelJson = VerifyModel.fromJson(jsonBody);
        return response.statusCode;
      } else {
        //! servis hatasi bilgisi.
        return response.statusCode;
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
