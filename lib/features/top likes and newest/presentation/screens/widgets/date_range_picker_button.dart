import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerButton extends StatelessWidget {
  const DateRangePickerButton({
    super.key,
    required this.dateRange,
    required this.onPressed,
  });

  final DateTimeRange? dateRange;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String text;
    if (dateRange == null) {
      text = 'Pilih tanggal';
    } else {
      final start = DateFormat('dd/MM/yy').format(dateRange!.start);
      final end = DateFormat('dd/MM/yy').format(dateRange!.end);
      text = '$start - $end';
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: TColors.greyStroke, width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: TColors.secondaryText,
            ),
            const SizedBox(width: TSizes.smallSpace),
            Text(text, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
