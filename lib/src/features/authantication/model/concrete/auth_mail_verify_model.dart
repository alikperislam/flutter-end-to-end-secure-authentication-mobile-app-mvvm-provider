import 'package:enguide_app/src/core/encrypt/data_encrypt.dart';

class VerifyModel {
  String? verifyCode;
  String? toMailAddress;
  String? message;

  VerifyModel({this.verifyCode, this.toMailAddress, this.message});

  factory VerifyModel.fromJson(Map<String, dynamic> json) {
    return VerifyModel(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson({required VerifyModel verifyModel}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verifyCode'] = DataEncrypt.wrappingEncrypted(verifyModel.verifyCode);
    data['toMailAddress'] =
        DataEncrypt.wrappingEncrypted(verifyModel.toMailAddress);
    return data;
  }
}
