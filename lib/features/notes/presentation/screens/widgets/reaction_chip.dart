import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class ReactionChip extends StatelessWidget {
  const ReactionChip({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadiusGeometry.circular(30),
        border: Border.all(color: const Color(0xFFD9D9D9), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: TSizes.smallSpace / 2),
          Text('100', style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
