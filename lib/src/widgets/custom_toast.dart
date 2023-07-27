import 'package:fluttertoast/fluttertoast.dart';
import 'package:nafcassete/src/helpers/styles.dart';

showToastMessage(message) {
  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_LONG,
    msg: message,
    gravity: ToastGravity.TOP,
    textColor: red,
    backgroundColor: white,
  );
}