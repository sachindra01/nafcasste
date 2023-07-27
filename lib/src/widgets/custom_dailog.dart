import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafcassete/src/helpers/styles.dart';

customDialogBox(context, title, onYes, onNo){
  return showDialog(
    context: context, 
    builder: (context){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 340.h
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: w6f15(black),),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: onYes,
                    child: Text("はい", style: w5f15(redCol),)
                  ),
                  SizedBox(width: 20.w,),
                  GestureDetector(
                    onTap: onNo,
                    child: Text("いいえ", style: w5f15(black),)
                  ),
                ],
              )
            ],
          ),
        )
      );
    },
  );
}