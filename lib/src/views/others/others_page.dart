import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/auth/change_password.dart';
import 'package:nafcassete/src/views/auth/login_page.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({super.key});

  @override
  State<OthersPage> createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: extendedAppBar(),
        backgroundColor: white,
        body: Stack(
          children: [
            Column(
              children: [
                othersSection(const Icon(Icons.person_2_outlined), 'アカウント', () { }),
                othersSection(const Icon(Icons.question_mark_outlined), 'ヘルプ', () { }),
                othersSection(const Icon(Icons.note_add_outlined), '利用規約', () { }),
                othersSection(const Icon(Icons.security_outlined), '個人情報保護方針', () { Get.to(()=> const ChangePassword());}),
                othersSection(const Icon(Icons.email_outlined), 'お問い合わせ', () { }),
                Container(
                  height: 12.0.h,
                  color: grey,
                  width: double.infinity,
                ),
                othersSection(null, 'ログアウト', () {
                  Get.off(()=> const Login());
                  remove('tokenId');
                }),
              ],
            ),
            SizedBox(
              height: 650.0.h,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 18.0.h, right: 25.0.w),
                  child: Text("version 1.01", style: w4f13(black),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  othersSection(icon, title,VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: icon != null ? Container(
        color: white,
        height: 50.0.h,
        padding: EdgeInsets.only(right: 20.0.w, left: 5.0.w),
        child: Row(
          children: [
            SizedBox(
              width: 50.0.w,
              child: icon
            ),
            Text(title, style: w4f13(black),),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,size: 20.0.sp,)
          ],
        ),
      ) : 
      Container(
        color: white,
        height: 50.0.h,
        padding: EdgeInsets.only(right: 20.0.w, left: 20.0.w),
        child: Row(
          children: [
            Text(title, style: w4f13(black), textAlign: TextAlign.start,),
          ],
        ),
      )
    );
  }
}