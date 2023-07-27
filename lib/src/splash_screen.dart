import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/bottom_nav.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/views/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    var tokenId = read('tokenId');
    Timer(
      const Duration(seconds: 3),
      () {
        if(tokenId != null && tokenId != ""){
          Get.offAll(()=>const BottomNavbar(index: 2),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
        }
        else{
          Get.to(() => const Login(),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 244.0.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain
                ),
              ),
              child: const Center(child: Text('')),
            ),
            SizedBox(height: 20.0.h,),
            Container(
              height: 74.0.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/png/logo_showroom.png'),
                  fit: BoxFit.contain
                ),
              ),
              child: const Center(child: Text('')),
            ),
          ],
        ),
    );
  }

}