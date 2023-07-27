
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafcassete/src/helpers/styles.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback ?onTap;
  final String ?hintText;
  final Widget ?prefixIcon;
  final Color ?backgroundColor;
  const CustomSearchBar({super.key, this.onTap, this.hintText, this.prefixIcon, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14.0.h),
        prefixIconConstraints: BoxConstraints(
          minHeight: 30.h,
          minWidth: 50.w
        ),
        prefixIcon: prefixIcon ?? const Icon(Icons.search, color: black,),
        hintText: hintText ?? '商品をさがす',
        hintStyle: w5f12(textGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(color: grey)
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(color: grey)
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(color: grey)
        ),
        fillColor: backgroundColor ?? white,
        filled: true,
      ),
    );
  }
}