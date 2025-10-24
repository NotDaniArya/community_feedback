import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class ReactionChip extends StatelessWidget {
  const ReactionChip({super.key, required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: TSizes.smallSpace),
          Text('10', style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
