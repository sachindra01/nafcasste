

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';

AppBar customAppbar(title, [double ?elevation,action,leadIcon]) {
  return AppBar(
    title: SizedBox(
      width: 260.0.w,
      child: Center(child: Text(title, style: const TextStyle(overflow: TextOverflow.ellipsis),))
    ),
    backgroundColor: white,
    iconTheme: IconThemeData(color: title == 'ピン留め' ? redCol : darkGreyCol, size: 20.0.sp),
    titleTextStyle: w7f14(black),
    elevation: elevation,
    centerTitle: true,
    leading: leadIcon??IconButton(
      onPressed: () => Get.back(), 
      icon: const Icon(
        Icons.arrow_back_ios
      )
    ),
    actions:action?? [
      const Icon(Icons.more_horiz_rounded,),
      SizedBox(width: 12.0.w,)
    ],
  );
}



extendedAppBar(){
  return  PreferredSize(
    preferredSize: Size.fromHeight(300.h),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical:16.0.h),
      child: Row(
        children: [
          const SizedBox(),
          const Spacer(),
          Image.asset(
            'assets/images/menu_title.png',
            height: 47.0.h,
          ),
          SizedBox(width: 38.0.w,),
          Stack(
            children: [
              IconButton(
                onPressed: (){}, 
                icon:  Icon(
                  Icons.notifications_outlined, color: black,
                  size: 28.0.sp,
                )
              ),
              Positioned(
                top: 12.0.h,
                right: 14.0.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0.r),
                  child:Container( 
                    height: 10.0.h,
                    width: 10.0.h,
                    color: red,
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 10.0.w,)
        ],
      ),
    )
  );

}