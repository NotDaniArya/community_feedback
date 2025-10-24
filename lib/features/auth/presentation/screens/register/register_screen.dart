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
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Disini Logo', style: textTheme.titleMedium),
                            const SizedBox(height: TSizes.spaceBtwSections),
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
                            TInputTextField(
                              icon: Icons.email_rounded,
                              labelText: 'Email',
                              inputType: TextInputType.emailAddress,
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
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
                            TextFormField(
                              obscureText: !_isPasswordVisible,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
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
                            const SizedBox(height: TSizes.spaceBtwSections),
                            SizedBox(
                              width: double.infinity,
                              child: MyButton(
                                text: Text(
                                  'Daftar',
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: _submitSignUp,
                              ),
                            ),
                            const SizedBox(height: TSizes.mediumSpace),
                            const OrDivider(),
                            const SizedBox(height: TSizes.mediumSpace),
                            const MyTextButton(
                              text: Text('Sudah Punya Akun?'),
                              buttonText: Text('Masuk sekarang'),
                              route: LoginScreen(),
                            ),
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
