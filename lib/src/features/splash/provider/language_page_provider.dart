import 'package:flutter/material.dart';

class LanguagePageProvider extends ChangeNotifier {
  // secilen dillerin bool turunden gorunumleri
  List<bool> chooseLangList = [false, false, false, false, false, false];
  // secilen dilin border color ve buton gorunumlerini true yapan algoritma.
  void chooseIndex(int index) {
    int indexList = 0;
    for (int j = 0; j < 6; j++) {
      if (index == indexList) {
        chooseLangList[indexList] = true;
      } else {
        chooseLangList[indexList] = false;
      }
      indexList++;
    }
    notifyListeners();
  }
}
