import 'package:fluttertoast/fluttertoast.dart';

customToast({
  String message = 'Please fill out the required data',
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
  );
}
