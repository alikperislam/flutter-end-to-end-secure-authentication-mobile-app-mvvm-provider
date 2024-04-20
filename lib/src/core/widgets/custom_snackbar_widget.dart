import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static customSnackBar({
    required String errorMessage,
    required ContentType contentType,
    required String title,
    required BuildContext context,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title, //! localekeys olarak gelsin baslik.
        message: errorMessage, //! message
        contentType: contentType, //! warning or info or etc.
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
