import 'package:enguide_app/src/core/encrypt/data_encrypt.dart';
import 'package:enguide_app/src/features/authantication/model/abstract/i_auth_model.dart';

class AuthLogInModel implements IAuthModel {
  @override
  String? mailText;
  @override
  String? passwordText;
  String? message;
  String? token;
  int? statusCode;
  String? name;

  AuthLogInModel({
    this.mailText,
    this.passwordText,
    this.message,
    this.token,
    this.statusCode,
    this.name,
  });

  factory AuthLogInModel.fromJson(
    Map<String, dynamic> json,
    String token,
    int statusCode,
  ) {
    return AuthLogInModel(
      message: DataEncrypt.wrappingDecrypted(json['message']) ?? '',
      name: DataEncrypt.wrappingDecrypted(json['name']) ?? '',
      token: token,
      statusCode: statusCode,
    );
  }
  factory AuthLogInModel.fromJsonOnlyStatusCode(
    int statusCode,
  ) {
    return AuthLogInModel(
      statusCode: statusCode,
    );
  }

  Map<String, dynamic> toJson({required AuthLogInModel authLogInModel}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mailText'] = DataEncrypt.wrappingEncrypted(authLogInModel.mailText);
    data['passwordText'] =
        DataEncrypt.wrappingEncrypted(authLogInModel.passwordText);
    return data;
  }
}
