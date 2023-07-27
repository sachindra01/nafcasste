import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';

loadingWidget([bgColor,color]){
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SizedBox(
          height:  35.0,
          width: 35.0,
          child: CircularProgressIndicator(
            backgroundColor: bgColor??white,
            color: color??redCol,
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}