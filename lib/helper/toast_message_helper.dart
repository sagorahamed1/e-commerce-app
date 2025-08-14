import 'package:flutter/material.dart';
import '../core/app_constants/app_colors.dart';

class ToastMessageHelper {
  static void showToastMessage(BuildContext context, String message, {String title = 'Success'}) {
    Color backgroundColor = AppColors.primaryColor;
    Icon icon = const Icon(Icons.check, color: Colors.white);

    switch (title.toLowerCase()) {
      case 'warning':
      case 'caution':
      case 'attention':
        backgroundColor = Colors.orange;
        icon = const Icon(Icons.warning, color: Colors.white);
        break;
      case 'error':
      case 'failed':
        backgroundColor = Colors.red;
        icon = const Icon(Icons.error, color: Colors.white);
        break;
      case 'info':
        backgroundColor = Colors.blue;
        icon = const Icon(Icons.info, color: Colors.white);
        break;
      default:
        backgroundColor = AppColors.primaryColor;
        icon = const Icon(Icons.check, color: Colors.white);
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
