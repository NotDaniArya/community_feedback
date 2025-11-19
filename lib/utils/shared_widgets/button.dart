import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  final Widget text;
  final void Function()? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(36),
        ),
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
      ),
      child: text,
    );
  }
}
