import 'package:community_feedback/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class FilterToogleButton extends StatelessWidget {
  const FilterToogleButton({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: TColors.greyStroke, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(context, 'Top Like', 0),
          _buildToggleButton(context, 'Newest', 1),
        ],
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context, String text, int index) {
    final textTheme = Theme.of(context).textTheme;
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? TColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: textTheme.bodySmall!.copyWith(
            color: isSelected ? Colors.white : TColors.secondaryText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
          ),
        ),
      ),
    );
  }
}
