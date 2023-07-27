import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const white =  Color(0xFFFFFFFF);
const black =  Color(0xFF000000);
const topBarCol = Color(0xFFDDDDDD);
const grey = Color(0xFFE7E7E7);
const lightgrey = Color(0xFFE7E7E7);
const iconGrey = Color(0xFF838383);
const textGrey = Color(0xFF6F6F6F);
const red = Color(0xFFDA3F45);
const lightblue = Color(0xFF5FBCFF);
const darkBlue = Color(0xFF2E3C52);
const darkgrey = Color(0xFF868686

);

//product_garage_v1 Styles
const redCol = Color(0xFFE02D2D);
const darkGreyCol = Color(0xFF677883);
const greyCol = Color(0xFF9CAEB7);
const lightGreyCol = Color(0xFFCDD4D9);


//Fonts
logoFontStyle() => GoogleFonts.inter(
  fontSize: 22.sp, 
  fontWeight: FontWeight.w600,
  color: redCol,
);

w7f15([color]) => GoogleFonts.inter(
  fontSize: 15.sp, 
  fontWeight: FontWeight.w700,
  color: color,
);

w7f14([color]) => GoogleFonts.inter(
  fontSize: 14.sp, 
  fontWeight: FontWeight.w700,
  color: color,
  decoration: TextDecoration.none
);

w7f20([color]) => GoogleFonts.inter(
  fontSize: 20.sp, 
  fontWeight: FontWeight.w700,
  color: color,
  decoration: TextDecoration.none
);

w7f12([color]) => GoogleFonts.inter(
  fontSize: 12.sp, 
  fontWeight: FontWeight.w700,
  color: color,
);

w7f12N([color]) => GoogleFonts.inter(
  fontSize: 12.sp, 
  fontWeight: FontWeight.w700,
  color: color,
  decoration: TextDecoration.none
);

w7f30([color]) => GoogleFonts.inter(
  fontSize: 30.sp, 
  fontWeight: FontWeight.w700,
  color: color,
);

w5f9([color]) => GoogleFonts.inter(
  fontSize: 9.sp, 
  fontWeight: FontWeight.w500,
  color: color,
);

w5f8([color]) => GoogleFonts.inter(
  fontSize: 8.sp, 
  fontWeight: FontWeight.w500,
  color: color,
);

w5f10([color]) => GoogleFonts.inter(
  fontSize: 10.sp, 
  fontWeight: FontWeight.w500,
  color: color,
);

w5f12([color]) => GoogleFonts.inter(
  fontSize: 12.sp, 
  fontWeight: FontWeight.w500,
  color: color,
);

w5f15([color]) => GoogleFonts.inter(
  fontSize: 15.sp, 
  fontWeight: FontWeight.w500,
  color: color,
);

w6f12([color]) => GoogleFonts.inter(
  fontSize: 12.sp, 
  fontWeight: FontWeight.w600,
  color: color,
  decoration: TextDecoration.none
);

w6f13([color]) => GoogleFonts.inter(
  fontSize: 13.sp, 
  fontWeight: FontWeight.w600,
  color: color,
  decoration: TextDecoration.none
);

w6f23([color]) => GoogleFonts.inter(
  fontSize: 23.sp, 
  fontWeight: FontWeight.w600,
  color: color,
);

w6f15([color]) => GoogleFonts.inter(
  fontSize: 15.sp, 
  fontWeight: FontWeight.w600,
  color: color,
  decoration: TextDecoration.none
);

w4f12([color]) => GoogleFonts.inter(
  fontSize: 12.sp, 
  fontWeight: FontWeight.w400,
  color: color,
);

w4f13([color]) => GoogleFonts.inter(
  fontSize: 13.sp, 
  fontWeight: FontWeight.w400,
  color: color,
);

w4f14([color]) => GoogleFonts.inter(
  fontSize: 14.sp, 
  fontWeight: FontWeight.w400,
  color: color,
);

w4f9([color]) => GoogleFonts.inter(
  fontSize: 9.sp, 
  fontWeight: FontWeight.w400,
  color: color,
);


class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}