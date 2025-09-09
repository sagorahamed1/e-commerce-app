import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ToastMessageHelper {
  static void showToastMessage(BuildContext context, String message, {String title = 'Success'}) {
    Color backgroundColor = Colors.green;
    IconData iconData = Icons.check;

    switch (title.toLowerCase()) {
      case 'warning':
        backgroundColor = Colors.orange;
        iconData = Icons.warning;
        break;
      case 'error':
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case 'info':
        backgroundColor = Colors.blue;
        iconData = Icons.info;
        break;
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      icon: Icon(iconData, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
    );
  }
}
