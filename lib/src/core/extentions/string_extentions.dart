import 'package:easy_localization/easy_localization.dart';
import 'package:enguide_app/src/core/constants/app_constants.dart';

//? direkt string uzerinden metne erismek icin extention olusturduk.
extension StringLocalization on String {
  String get locale => this.tr();
}

//? ilgili metnin ilk elemanini donen extention.
extension FirstElement on String {
  String get firstElement => split(" ").first;
}

//? Text icerisinde istenilen kelimeyi farkli bir renge boyamak icin text'e ait string uzerine yazilan algoritma.
extension TextIndexColorExtention on String {
  List<String> get isEnguide {
    //? kelimenin konumuna gore doldurulacak olan liste.
    List<String> textData = [];
    textData.clear();
    //? boyanmak istenilen kelimenin indexi alinarak cumle icerisindeki yeri belirlenecek ve liste doldurulacak.
    int wordIndex = locale.indexOf(searchWord);
    if (wordIndex != -1) {
      String before = locale.substring(0, wordIndex);
      String after = locale.substring(wordIndex + searchWord.length);

      textData.add(before.trim());
      textData.add(searchWord);
      textData.add(after.trim());
    } else {
      textData.add(locale.trim());
    }
    //? bos elemani listeden kaldir.
    if (textData.contains('')) {
      textData.removeWhere((element) => element == '');
    }
    return textData;
  }
}
