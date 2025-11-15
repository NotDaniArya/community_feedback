import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalContainer extends StatelessWidget {
  const PersonalContainer({
    super.key,
    required this.textTheme,
    required this.content,
  });

  final TextTheme textTheme;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.mediumSpace,

        vertical: TSizes.smallSpace / 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TColors.secondaryText, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              content,
              style: textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwSections),
          IconButton(
            onPressed: () {},
            icon: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.pen,
                  size: 15,
                  color: TColors.primaryColor,
                ),
                const SizedBox(width: TSizes.smallSpace),
                Text(
                  'Edit',
                  style: textTheme.labelMedium!.copyWith(
                    color: TColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
