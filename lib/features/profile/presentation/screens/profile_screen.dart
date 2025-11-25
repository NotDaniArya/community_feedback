import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/our%20developer/presentation/our_developer_screen.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_email_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_name_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_cubit.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_state.dart';
import 'package:community_feedback/features/profile/presentation/screens/widgets/change_email_sheet.dart';
import 'package:community_feedback/features/profile/presentation/screens/widgets/change_name_sheet.dart';
import 'package:community_feedback/features/profile/presentation/screens/widgets/change_password_sheet.dart';
import 'package:community_feedback/features/profile/presentation/screens/widgets/personal_container.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:community_feedback/utils/shared_widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ProfileCubit(
        authLocalDataSource: context.read<AuthLocalDataSource>(),
        changePasswordUseCase: context.read<ChangePasswordUsecase>(),
        changeEmailUseCase: context.read<ChangeEmailUseCase>(),
        changeNameUseCase: context.read<ChangeNameUseCase>(),
      )..loadUserProfile(),
      child: Scaffold(
        backgroundColor: TColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.scaffoldPadding),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                String displayName = 'Loading...';
                String displayEmail = 'Loading...';

                if (state is ProfileLoaded) {
                  displayName = state.name;
                  displayEmail = state.email;
                } else {
                  displayName;
                  displayEmail;
                }

                return Column(
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
                          child: Text(
                            'Signed in as',
                            style: textTheme.bodyMedium,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideX(begin: -0.2, curve: Curves.easeOut),
                    Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            displayName,
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
                            displayEmail,
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
                                content: displayName,
                                onPressed: () {
                                  final profileCubit = context
                                      .read<ProfileCubit>();

                                  MyHelperFunction.showModalBottom(
                                    context: context,
                                    screen: BlocProvider.value(
                                      value: profileCubit,
                                      child: ChangeNameSheet(
                                        textTheme: textTheme,
                                      ),
                                    ),
                                  );
                                },
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
                                content: displayEmail,
                                onPressed: () {
                                  final profileCubit = context
                                      .read<ProfileCubit>();

                                  MyHelperFunction.showModalBottom(
                                    context: context,
                                    screen: BlocProvider.value(
                                      value: profileCubit,
                                      child: ChangeEmailSheet(
                                        textTheme: textTheme,
                                      ),
                                    ),
                                  );
                                },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    onPressed: () {
                                      final profileCubit = context
                                          .read<ProfileCubit>();

                                      MyHelperFunction.showModalBottom(
                                        context: context,
                                        screen: BlocProvider.value(
                                          value: profileCubit,
                                          child: ChangePasswordSheet(
                                            textTheme: textTheme,
                                          ),
                                        ),
                                      );
                                    },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Our Developer',
                                          style: textTheme.titleMedium!
                                              .copyWith(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
