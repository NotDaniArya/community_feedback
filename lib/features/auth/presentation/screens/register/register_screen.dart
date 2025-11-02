import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  String _enteredFullName = '';
  String _enteredEmail = '';
  bool _isPasswordVisible = false;

  void _submitSignUp() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    // ref
    //     .read(authNotifierProvider.notifier)
    //     .register(
    //       name: _enteredFullName,
    //       email: _enteredEmail,
    //       password: _passwordController.text,
    //       passwordConfirm: _passwordController.text,
    //     );
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.scaffoldPadding),
            child: Form(
              key: _form,
              child: Container(
                margin: const EdgeInsets.only(bottom: 45),
                child:
                    // Logo aplikasi
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: TColors.primaryColor.withOpacity(
                                          0.2,
                                        ),
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
                            const SizedBox(height: TSizes.spaceBtwSections),

                            // New here text
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
                                ).animate().fadeIn(
                                  delay: 300.ms,
                                  duration: 500.ms,
                                ),
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

                            // form register
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
                              child: Column(
                                children: [
                                  // field full name
                                  TInputTextField(
                                    labelText: 'Full Name',
                                    maxLength: 50,
                                    icon: Icons.person,
                                    minLength: 4,
                                    inputType: TextInputType.name,
                                    onSaved: (value) {
                                      _enteredFullName = value!;
                                    },
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  // field email
                                  TInputTextField(
                                    icon: Icons.email_rounded,
                                    labelText: 'Email',
                                    inputType: TextInputType.emailAddress,
                                    onSaved: (value) {
                                      _enteredEmail = value!;
                                    },
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  // field password
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: !_isPasswordVisible,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: TColors.primaryColor,
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
                                              ? Icons.visibility
                                              : Icons.visibility_off,
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
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  // field confirm password
                                  TextFormField(
                                    obscureText: !_isPasswordVisible,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: TColors.primaryColor,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      isDense: true,
                                    ),
                                    maxLength: 15,
                                    autocorrect: false,
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'Password anda tidak sama';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: TSizes.spaceBtwSections,
                                  ),

                                  // button register
                                  SizedBox(
                                    width: double.infinity,
                                    child: MyButton(
                                      text: Text(
                                        'Register',
                                        style: textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: _submitSignUp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // sudah punya akun text
                            const MyTextButton(
                              text: Text('Sudah Punya Akun?'),
                              buttonText: Text('Masuk sekarang'),
                              route: LoginScreen(),
                            ),
                            const OrDivider(),
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
                                        color: TColors.greyStroke.withOpacity(
                                          0.5,
                                        ),
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
                          ],
                        )
                        .animate(delay: 70.ms)
                        .fade(duration: 600.ms, curve: Curves.easeOut)
                        .slide(
                          begin: const Offset(0, 0.2),
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
