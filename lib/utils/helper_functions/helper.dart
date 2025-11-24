import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class MyHelperFunction {
  static void showToast(
    BuildContext context,
    String message,
    String description,
    ToastificationType? type,
  ) {
    final textTheme = Theme.of(context).textTheme;

    toastification.dismissAll();
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      title: Text(
        message,
        style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(description, style: textTheme.bodySmall),
      alignment: Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 5),
      icon: type == ToastificationType.success && type != null
          ? const Icon(Icons.check_circle)
          : const Icon(Icons.error),
    );
  }

  static void showModalBottom({
    required BuildContext context,
    required Widget screen,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => screen,
    );
  }
}
