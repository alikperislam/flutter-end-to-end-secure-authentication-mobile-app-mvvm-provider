import 'package:enguide_app/src/core/utils/color_palette.dart';
import 'package:enguide_app/src/core/utils/image_manager.dart';
import 'package:enguide_app/src/features/authantication/provider/auth_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AuthBaseWidget extends StatefulWidget {
  Widget outsourceWidget;
  AuthBaseWidget({super.key, required this.outsourceWidget});

  @override
  State<AuthBaseWidget> createState() => _AuthBaseWidgetState();
}

class _AuthBaseWidgetState extends State<AuthBaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRegisterProvider>(
      builder: (_, value, __) {
        return SingleChildScrollView(
          //? verify sayfasinda kaydirma islemini engelle.
          physics: value.verify
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // shape container
                const BgShape(),
                // container - diger 3 sayfada kullanilacak komponentler dis kaynak olarak alinmis olacak!
                CenterContainer(outsourceWidget: widget.outsourceWidget),
                // meta logo
                const Logo(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BgShape extends StatelessWidget {
  const BgShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalette.purpleColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.elliptical(300.r, 40.r),
          bottomStart: Radius.elliptical(300.r, 40.r),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          ImageManager.white_logo,
          width: 280.w,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CenterContainer extends StatelessWidget {
  Widget outsourceWidget;
  CenterContainer({
    super.key,
    required this.outsourceWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 1550.h,
        width: 900.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: outsourceWidget,
      ),
    );
  }
}
