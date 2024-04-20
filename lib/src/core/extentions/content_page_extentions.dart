import 'package:enguide_app/src/core/constants/app_constants.dart';
import 'package:enguide_app/src/core/extentions/string_extentions.dart';
import 'package:enguide_app/src/core/init/localization/locale_keys.g.dart';
import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/features/splash/view/ui/splash_screen_content_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//? Uygulama arayuzunde gosterilecek olan widgetlarin bulundugu Content class'ina ozgu bir extention.
extension ContentPageExtentions on Content {
  TextSpan get contentDetail {
    //? LocaleKeys ile lokalizasyon paketi uzerinden ilgili metne erisiyoruz.
    List<String> enguideData = LocaleKeys.contentPageContent
        .isEnguide; //? isEnguide diger extention'dan gelen getter'dir.
    return TextSpan(
      children: [
        //? liste elemani kadar (2 veya 3) TextSpan uretme mekanizmasi.
        for (int i = 0; i < enguideData.length; i++) ...[
          TextSpan(
            text: getText(enguideData, i),
            style: TextStyle(
              //? metin icerisindeki kelime "Enguide" ise rengini mor yapacak. digerleri ise default renkte kalacak.
              color: enguideData[i] == searchWord
                  ? ColorPalette.purpleColor
                  : ColorPalette.languageChooseTextColor,
              fontSize: 45.sp,
            ),
          ),
        ],
      ],
    );
  }
}

//? listeden donen degerlerin textspanda yazdirilmasi islemi.(enguidenin durumuna gore bosluk ekleniyor)
String getText(List<String> enguideData, int i) {
  return enguideData[i] == searchWord && i == 0
      ? "${enguideData[i]} "
      : enguideData[i] == searchWord && i != 0
          ? " ${enguideData[i]} "
          : enguideData[i];
}
