import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_cubit.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_state.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _form = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmationController = TextEditingController();
  bool isCurrentPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();
    super.dispose();
  }

  void submitChangePassword() {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    context.read<ProfileCubit>().changeUserPassword(
      currentPassword: _currentPasswordController.text.trim(),
      password: _newPasswordController.text.trim(),
      passwordConfirmation: _newPasswordConfirmationController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = widget.textTheme;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }

        if (state is ProfileSuccess) {
          MyHelperFunction.showToast(
            context,
            'Successful',
            'Successfully changed the password',
            ToastificationType.success,
          );

          Navigator.pop(context);
        } else if (state is ProfileError) {
          MyHelperFunction.showToast(
            context,
            'Failed',
            state.message,
            ToastificationType.error,
          );
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.scaffoldPadding).copyWith(
            bottom:
                MediaQuery.of(context).viewInsets.bottom + TSizes.mediumSpace,
          ),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text('Change Password', style: textTheme.titleLarge),
                const SizedBox(height: TSizes.spaceBtwSections),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'Current Password',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _currentPasswordController,
                  maxLength: 12,
                  obscureText: !isCurrentPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isCurrentPasswordVisible = !isCurrentPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isCurrentPasswordVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: TColors.secondaryText,
                      ),
                    ),
                    hintText: 'Enter current password',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _currentPasswordController.text = value!;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Password',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _newPasswordController,
                  maxLength: 12,
                  obscureText: isNewPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter new password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isNewPasswordVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: TColors.secondaryText,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 8) {
                      return 'The password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPasswordController.text = value!;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'New Password Confirmation',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _newPasswordConfirmationController,
                  maxLength: 12,
                  obscureText: isNewPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Re-enter your new password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isNewPasswordVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: TColors.secondaryText,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim() != _newPasswordController.text) {
                      return 'Your new password is not the same';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPasswordConfirmationController.text = value!;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                ButtonRadiusEight(
                  textTheme,
                  bgColor: TColors.primaryColor,
                  textColor: Colors.white,
                  child: [
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Submit',
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ],
                  onPressed: submitChangePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
