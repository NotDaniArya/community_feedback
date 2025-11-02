import 'package:community_feedback/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../utils/constant/colors.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/shared_widgets/button.dart';
import '../../../../../utils/shared_widgets/input_text_field.dart';
import '../../../../../utils/shared_widgets/or_divider.dart';
import '../../../../../utils/shared_widgets/text_button.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPass = '';
  bool _isPasswordVisible = false;

  void _submitLogin() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    // ref
    //     .read(authNotifierProvider.notifier)
    //     .login(email: _enteredEmail, password: _enteredPass);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    // ref.listen(authNotifierProvider, (previous, next) {
    //   if (next is AsyncError) {
    //     MyHelperFunction.showToast(
    //       context,
    //       'Login Gagal',
    //       'Email atau password anda mungkin saja salah atau belum terdaftar',
    //       ToastificationType.error,
    //     );
    //   }
    //
    //   if (next is AsyncData && next.value != null) {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => const AuthGate()),
    //       (route) => false,
    //     );
    //   }
    // });

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SafeArea(
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
                // Logo aplikasi
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
                          'Welcome Back!',
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
                      'Login to your account to continue',
                      style: textTheme.bodyMedium!.copyWith(
                        color: TColors.secondaryText,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // gambar auth
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
                                .fadeIn(delay: 500.ms, duration: 400.ms)
                                .slideX(begin: -0.1, duration: 400.ms),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Password Field
                            TextFormField(
                                  obscureText: !_isPasswordVisible,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.lock_rounded,
                                      color: TColors.primaryColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 45, 25, 25),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: TColors.greyStroke,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
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
                                  maxLength: 30,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 8) {
                                      return 'Panjang input minimal 8 karakter';
                                    }

                                    return null;
                                  },
                                  onSaved: (value) {
                                    _enteredPass = value!;
                                  },
                                )
                                .animate()
                                .fadeIn(delay: 600.ms, duration: 400.ms)
                                .slideX(begin: -0.1, duration: 400.ms),
                            const SizedBox(height: TSizes.largeSpace),

                            // Login Button
                            SizedBox(
                                  width: double.infinity,
                                  child: MyButton(
                                    text: Text(
                                      'Login',
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NavigationMenu(),
                                        ),
                                        (route) => false,
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

                const SizedBox(height: TSizes.spaceBtwItems),

                // Register Link
                MyTextButton(
                  text: Text(
                    'Don\'t have an account?',
                    style: textTheme.bodyMedium!.copyWith(
                      color: TColors.secondaryText,
                    ),
                  ),
                  buttonText: Text(
                    'Register',
                    style: textTheme.bodyMedium!.copyWith(
                      color: TColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  route: const RegisterScreen(),
                ).animate().fadeIn(delay: 800.ms, duration: 400.ms),

                // Divider
                const OrDivider().animate().fadeIn(
                  delay: 900.ms,
                  duration: 400.ms,
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

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
    );
  }
}
