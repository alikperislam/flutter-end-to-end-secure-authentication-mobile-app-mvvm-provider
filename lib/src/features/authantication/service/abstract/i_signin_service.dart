import 'package:enguide_app/src/features/authantication/model/concrete/auth_sign_in_model.dart';

abstract class ISignInService {
  Future<AuthSignInModel?> postSignIn({
    required String url,
    required AuthSignInModel model,
  });
}
