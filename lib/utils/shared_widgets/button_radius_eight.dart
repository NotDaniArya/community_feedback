import 'package:flutter/material.dart';

ElevatedButton ButtonRadiusEight(
  TextTheme textTheme, {
  required Color bgColor,
  required Color textColor,
  required List<Widget> child,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
      backgroundColor: bgColor,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
      ),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: child),
  );
}
