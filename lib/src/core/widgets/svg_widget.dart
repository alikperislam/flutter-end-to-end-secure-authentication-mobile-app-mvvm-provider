// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class SvgImageWidget extends StatelessWidget {
  double top;
  double bottom;
  double left;
  double right;
  String image;
  double width;
  double height;

  SvgImageWidget({super.key, 
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.image,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top.h,
        bottom: bottom.h,
        left: left.w,
        right: right.w,
      ),
      child: SvgPicture.asset(
        image,
        width: width.r,
        height: height.r,
      ),
    );
  }
}
