import 'package:community_feedback/features/auth/domain/usecases/register_usecase.dart';
import 'package:community_feedback/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:community_feedback/features/auth/presentation/cubit/register/register_state.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/shared_widgets/button.dart';
import '../../../../../utils/shared_widgets/input_text_field.dart';
import '../../../../../utils/shared_widgets/or_divider.dart';
import '../../../../../utils/shared_widgets/text_button.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  String _enteredName = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredPasswordConfirmation = '';
  bool _isPasswordVisible = false;

  void _submitSignUp(BuildContext cubitContext) {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    cubitContext.read<RegisterCubit>().doRegister(
      name: _enteredName,
      email: _enteredEmail,
      password: _enteredPassword,
      passwordConfirmation: _enteredPasswordConfirmation,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: BlocProvider(
        create: (context) => RegisterCubit(context.read<RegisterUsecase>()),
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              MyHelperFunction.showToast(
                context,
                'Register Berhasil!',
                'Silahkan login untuk masuk',
                ToastificationType.success,
              );
            } else if (state is RegisterError) {
              MyHelperFunction.showToast(
                context,
                'Register Gagal!',
                state.message,
                ToastificationType.error,
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.scaffoldPadding,
                  vertical: TSizes.largeSpace,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo Section with Animation
                    Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: TColors.primaryColor.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/logos/app_logo.png',
                            height: 80,
                            width: 80,
                          ),
                        )
                        .animate()
                        .scale(
                          delay: 100.ms,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        )
                        .fadeIn(duration: 500.ms),
                    const SizedBox(height: TSizes.largeSpace),

                    // Welcome Text
                    Column(
                      children: [
                        Text(
                              'New Here?',
                              style: textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 500.ms)
                            .slideY(begin: -0.2, duration: 500.ms),
                        const SizedBox(height: TSizes.smallSpace),
                        Text(
                          'Register to get started',
                          style: textTheme.bodyMedium!.copyWith(
                            color: TColors.secondaryText,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Auth Image
                    Image.asset(
                          'assets/images/auth_image.png',
                          height: size.height * 0.2,
                          fit: BoxFit.contain,
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 500.ms)
                        .slideY(begin: 0.1, duration: 500.ms),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Form Card
                    Container(
                          padding: const EdgeInsets.all(TSizes.largeSpace),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Full Name Field
                                TInputTextField(
                                      labelText: 'Your Name',
                                      maxLength: 50,
                                      icon: Icons.person_rounded,
                                      minLength: 4,
                                      inputType: TextInputType.name,
                                      onSaved: (value) {
                                        _enteredName = value!;
                                      },
                                    )
                                    .animate()
                                    .fadeIn(delay: 500.ms, duration: 400.ms)
                                    .slideX(begin: -0.1, duration: 400.ms),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                // Email Field
                                TInputTextField(
                                      icon: Icons.email_rounded,
                                      labelText: 'Email',
                                      inputType: TextInputType.emailAddress,
                                      onSaved: (value) {
                                        _enteredEmail = value!;
                                      },
                                      maxLength: 50,
                                    )
                                    .animate()
                                    .fadeIn(delay: 550.ms, duration: 400.ms)
                                    .slideX(begin: -0.1, duration: 400.ms),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                // Password Field
                                TextFormField(
                                      controller: _passwordController,
                                      obscureText: !_isPasswordVisible,
                                      keyboardType: TextInputType.text,
                                      onSaved: (value) {
                                        _enteredPassword = value!;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(
                                          Icons.lock_rounded,
                                          color: TColors.primaryColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.greyStroke,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.greyStroke,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.primaryColor,
                                            width: 2,
                                          ),
                                        ),

                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            color: TColors.secondaryText,
                                          ),
                                        ),
                                        isDense: true,
                                      ),
                                      maxLength: 15,
                                      autocorrect: false,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.trim().length < 8) {
                                          return 'Panjang input minimal 8 karakter';
                                        }
                                        return null;
                                      },
                                    )
                                    .animate()
                                    .fadeIn(delay: 600.ms, duration: 400.ms)
                                    .slideX(begin: -0.1, duration: 400.ms),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                // Confirm Password Field
                                TextFormField(
                                      obscureText: !_isPasswordVisible,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        prefixIcon: const Icon(
                                          Icons.lock_rounded,
                                          color: TColors.primaryColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.greyStroke,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.greyStroke,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: const BorderSide(
                                            color: TColors.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off_rounded,
                                            color: TColors.secondaryText,
                                          ),
                                        ),
                                        isDense: true,
                                      ),
                                      maxLength: 15,
                                      autocorrect: false,
                                      onSaved: (value) {
                                        _enteredPasswordConfirmation = value!;
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value != _passwordController.text) {
                                          return 'Password anda tidak sama';
                                        }
                                        return null;
                                      },
                                    )
                                    .animate()
                                    .fadeIn(delay: 650.ms, duration: 400.ms)
                                    .slideX(begin: -0.1, duration: 400.ms),
                                const SizedBox(height: TSizes.largeSpace),

                                // Register Button
                                SizedBox(
                                      width: double.infinity,
                                      child:
                                          BlocBuilder<
                                            RegisterCubit,
                                            RegisterState
                                          >(
                                            builder: (context, state) {
                                              if (state is RegisterLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return MyButton(
                                                text: Text(
                                                  'Register',
                                                  style: textTheme.bodyLarge!
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                onPressed: () =>
                                                    _submitSignUp(context),
                                                color: TColors.primaryColor,
                                              );
                                            },
                                          ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 700.ms, duration: 400.ms)
                                    .slideY(begin: 0.1, duration: 400.ms),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 500.ms)
                        .slideY(
                          begin: 0.2,
                          duration: 500.ms,
                          curve: Curves.easeOut,
                        ),

                    const SizedBox(height: TSizes.largeSpace),

                    // Login Link
                    MyTextButton(
                      text: Text(
                        'Already have an account?',
                        style: textTheme.bodyMedium!.copyWith(
                          color: TColors.secondaryText,
                        ),
                      ),
                      buttonText: Text(
                        'Login',
                        style: textTheme.bodyMedium!.copyWith(
                          color: TColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      route: const LoginScreen(),
                    ).animate().fadeIn(delay: 800.ms, duration: 400.ms),

                    const SizedBox(height: TSizes.largeSpace),

                    // Divider
                    const OrDivider().animate().fadeIn(
                      delay: 900.ms,
                      duration: 400.ms,
                    ),

                    const SizedBox(height: TSizes.largeSpace),

                    // Google Sign In Button
                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey[900],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: TColors.greyStroke.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/logos/google_icon.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Continue with Google',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 1000.ms, duration: 400.ms)
                        .slideY(begin: 0.1, duration: 400.ms),

                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
