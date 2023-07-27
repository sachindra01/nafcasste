import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(2),
      width: 65,
      height: 2.h,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,),
    );
  });
}

