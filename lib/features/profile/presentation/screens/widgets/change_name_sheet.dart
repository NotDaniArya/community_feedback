import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_cubit.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_state.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class ChangeNameSheet extends StatefulWidget {
  const ChangeNameSheet({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  State<ChangeNameSheet> createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  final _form = GlobalKey<FormState>();
  final _newUserName = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _newUserName.dispose();
    super.dispose();
  }

  void submitChangeUserName() {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    context.read<ProfileCubit>().changeUserName(
      newUserName: _newUserName.text.trim(),
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
            'Successfully changed your name',
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
                Text('Change Name', style: textTheme.titleLarge),
                const SizedBox(height: TSizes.spaceBtwSections),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'Name',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _newUserName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter new name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUserName.text = value!;
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
                  onPressed: submitChangeUserName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
