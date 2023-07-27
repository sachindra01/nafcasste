import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ja': {
      //Title
      "appTitle"       : "Products Garage",
      //Login Page
      "emailHint"      : "メールアドレス",
      "passwordHint"   : "パスワード",
      "loginText"      : "ログイン",
    },
  };
}