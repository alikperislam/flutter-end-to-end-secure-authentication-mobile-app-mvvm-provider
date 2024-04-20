import 'package:enguide_app/src/features/authantication/model/concrete/auth_log_in_model.dart';

abstract class ILogInService {
  Future<AuthLogInModel?> postLogIn({
    required String url,
    required AuthLogInModel model,
  });
}
