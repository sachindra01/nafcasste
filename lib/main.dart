import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/splash_screen.dart';
import 'src/helpers/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) { 
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'appTitle'.tr,
          home: const SplashScreen(),
          locale: const Locale('ja'),
          fallbackLocale: const Locale('ja'),
          defaultTransition: Transition.rightToLeft,
          translations: AppTranslations(),
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: child!,
            );
          },
        );
      },
    );
  }
}