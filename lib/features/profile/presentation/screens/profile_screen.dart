import 'package:community_feedback/features/profile/presentation/screens/widgets/personal_container.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/avatar_image.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:community_feedback/utils/shared_widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.scaffoldPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // text profile
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  'Profile',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // gambar profile
              ProfileImagePicker(
                onImageSelected: (image) {},
                initialImageUrl: 'https://i.pravatar.cc/150',
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              //user data
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('Signed in as', style: textTheme.bodyMedium),
              ),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Muhammad Dani Arya Putra ',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text('aryaarya@gmail.com', style: textTheme.bodyMedium),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // personal information,
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Personal Information',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.mediumSpace,
                  vertical: TSizes.mediumSpace,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TColors.secondaryText, width: 1),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.smallSpace),
                    PersonalContainer(
                      textTheme: textTheme,
                      content: 'Muhammad Dani Arya Putra',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: TSizes.smallSpace),
                    PersonalContainer(
                      textTheme: textTheme,
                      content: 'dani1234@gmail.com',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // security,
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Security',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.mediumSpace,
                  vertical: TSizes.mediumSpace,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TColors.secondaryText, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Password',
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Last modified 30 days ago',
                              style: textTheme.labelMedium,
                            ),
                          ],
                        ),
                        ButtonRadiusEight(
                          textTheme,
                          bgColor: TColors.primaryColor,
                          textColor: Colors.white,
                          child: [
                            Text(
                              'Change',
                              style: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // our developer,
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'App',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.mediumSpace,
                  vertical: TSizes.mediumSpace,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TColors.secondaryText, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Our Developer',
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Kenalan dengan tim pembuat aplikasi',
                                style: textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // button logout
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 110,
                  child: ButtonRadiusEight(
                    textTheme,
                    bgColor: Colors.red,
                    textColor: Colors.white,
                    child: [
                      const Icon(Icons.logout_outlined),
                      const SizedBox(width: TSizes.smallSpace),
                      Text(
                        'Logout',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
