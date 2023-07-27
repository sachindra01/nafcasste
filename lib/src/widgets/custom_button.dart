import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafcassete/src/helpers/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final Widget?prefixIcon;
  final Widget?suffixIcon;
  final String? text;
  final double? buttonRadius;
  final Color?bgColor;
  final Color?borderColor;
  final TextStyle?style;
  final double? elevation;
  final double? height;
  final double? width;
  const CustomButton({super.key, required this.ontap, this.prefixIcon, this.text, this.suffixIcon, this.buttonRadius, this.bgColor, this.style, this.borderColor, this.elevation, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? 57.h,
      width: width?? 298.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: white, 
          backgroundColor:bgColor?? redCol, // foreground
          elevation: elevation ?? 2.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor??Colors.transparent  ),
            borderRadius: BorderRadius.circular(buttonRadius??8.0.r),
          ),
        ),
        onPressed: ontap, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? const Icon(Icons.favorite,color: white,size: 18.0,),
            SizedBox(
              width: 5.w,
            ),
            Text( text ?? 'お気に入りに追加',style:style??w7f14(white)),
            SizedBox(
              width: 5.w,
            ),
            suffixIcon ?? const Icon(Icons.favorite,color: white,size: 18.0,),
          ],
        )
      ),
    );
  }
}