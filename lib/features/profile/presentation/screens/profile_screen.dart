import 'package:community_feedback/features/our%20developer/presentation/our_developer_screen.dart';
import 'package:community_feedback/features/profile/presentation/screens/widgets/personal_container.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:community_feedback/utils/shared_widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 100.ms)
                  .scale(begin: const Offset(0.8, 0.8)),
              const SizedBox(height: TSizes.spaceBtwSections),

              //user data
              Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text('Signed in as', style: textTheme.bodyMedium),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 200.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
              Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      'Muhammad Dani Arya Putra ',
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 250.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
              Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      'aryaarya@gmail.com',
                      style: textTheme.bodyMedium,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 350.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
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
                      border: Border.all(
                        color: TColors.secondaryText,
                        width: 1,
                      ),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 400.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 450.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
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
                      border: Border.all(
                        color: TColors.secondaryText,
                        width: 1,
                      ),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 550.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
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
                      border: Border.all(
                        color: TColors.secondaryText,
                        width: 1,
                      ),
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OurDeveloperScreen(),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  .animate() // --- ANIMASI ---
                  .fadeIn(duration: 400.ms, delay: 600.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
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
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 650.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}
