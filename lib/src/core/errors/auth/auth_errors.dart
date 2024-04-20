// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthErrorModel {
  String _errorMessage;
  AuthErrorModel(
    this._errorMessage,
  );
  String get getErrorFunction => _errorMessage;
  set setErrorFunction(String errorData) => _errorMessage = errorData;
}
