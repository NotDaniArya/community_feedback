import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/avatar_image.dart';
import 'package:community_feedback/utils/shared_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperContainer extends StatelessWidget {
  const DeveloperContainer({
    super.key,
    required this.textTheme,
    required this.profileImage,
    required this.name,
    required this.position,
    required this.description,
    required this.tools,
    required this.linkedinUrl,
    required this.email,
  });

  final TextTheme textTheme;
  final String profileImage;
  final String name;
  final String position;
  final String description;
  final List<Map<String, String>> tools;
  final String linkedinUrl;
  final String email;

  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      padding: const EdgeInsets.all(TSizes.spaceBtwItems),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TColors.secondaryText),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AvatarImage(imageUrl: profileImage),
          ),
          const SizedBox(height: TSizes.smallSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.largeSpace),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: TSizes.smallSpace,
                  horizontal: TSizes.mediumSpace,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.secondaryText),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  position,
                  style: textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(description, style: textTheme.bodyLarge),
          const SizedBox(height: TSizes.spaceBtwItems),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Tools:',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: TSizes.mediumSpace),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: tools.map((tool) {
              final String toolName = tool['name']!;
              final String iconPath = tool['icon']!;

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: TSizes.smallSpace,
                  horizontal: TSizes.mediumSpace,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.secondaryText),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(iconPath, width: 16, height: 16),
                    const SizedBox(width: TSizes.smallSpace),
                    Text(
                      toolName,
                      style: textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyButton(
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.userPlus,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: TSizes.smallSpace),
                      Text(
                        'Connect',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    launchURL(linkedinUrl);
                  },
                  color: TColors.primaryColor,
                ),
              ),
              const SizedBox(width: TSizes.smallSpace),
              Expanded(
                child: MyButton(
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.envelope,
                        color: TColors.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: TSizes.smallSpace),
                      Text(
                        'Email',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    launchURL(email);
                  },
                  color: TColors.secondaryButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
