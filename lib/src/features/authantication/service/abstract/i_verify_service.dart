import 'package:enguide_app/src/features/authantication/model/concrete/auth_mail_verify_model.dart';

abstract class IVerifyService {
  Future<int?> postMail({
    required String url,
    required VerifyModel model,
  });
}
