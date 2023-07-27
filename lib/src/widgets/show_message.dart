import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';

showMessage(title, content) {
  return Get.snackbar(
    title, 
    content,
    colorText: Get.isDarkMode ? white : black
  );
}