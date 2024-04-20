import 'package:enguide_app/src/core/encrypt/data_encrypt.dart';
import 'package:enguide_app/src/features/authantication/model/abstract/i_auth_model.dart';

class AuthSignInModel implements IAuthModel {
  @override
  late String? mailText;
  @override
  late String? passwordText;
  String? nameText;
  String? countryText;
  String? jobText;
  bool? gender;
  String? message;
  String? token;

  AuthSignInModel({
    this.mailText,
    this.passwordText,
    this.nameText,
    this.countryText,
    this.jobText,
    this.gender,
    this.message,
    this.token,
  });

  factory AuthSignInModel.fromJson(Map<String, dynamic> json, String token) {
    return AuthSignInModel(
      message: DataEncrypt.wrappingDecrypted(json['message']) ?? '',
      token: token,
    );
  }

  Map<String, dynamic> toJson({required AuthSignInModel authSignInModel}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mailText'] = DataEncrypt.wrappingEncrypted(authSignInModel.mailText);
    data['passwordText'] =
        DataEncrypt.wrappingEncrypted(authSignInModel.passwordText);
    data['nameText'] = DataEncrypt.wrappingEncrypted(authSignInModel.nameText);
    data['countryText'] =
        DataEncrypt.wrappingEncrypted(authSignInModel.countryText);
    data['jobText'] = DataEncrypt.wrappingEncrypted(authSignInModel.jobText);
    data['gender'] = DataEncrypt.wrappingEncrypted(authSignInModel.gender);
    return data;
  }
}
