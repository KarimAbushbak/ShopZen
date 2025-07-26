import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopzen/features/main_screen/main_screen.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_button.dart';
import '../../../../core/widgets/valideted_text_field.dart';
import '../controllers/signup_form_controllers.dart';
import '../cubit/sign_up_cubit.dart';
import '../../data/repos/auth_repository.dart';
import '../widget/show_login_success_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupFormControllers formControllers;

  @override
  void initState() {
    super.initState();
    formControllers = SignupFormControllers();
  }

  @override
  void dispose() {
    super.dispose();
    formControllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupFormCubit(authRepository: AuthRepository()),
      child: BlocBuilder<SignupFormCubit, SignupFormState>(
        builder: (context, state) {
          final cubit = context.read<SignupFormCubit>();
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: ManagerHeight.h24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w20,
                          ),
                          child: Text(
                            'SignUp With Email',
                            style: TextStyle(
                              color: ManagerColors.primaryTextColor,
                              fontWeight: ManagerFontWeight.bold,
                              fontSize: ManagerFontSizes.s24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ManagerHeight.h48),
                    ValidatedTextField(
                      title: 'Name',
                      hint: 'Enter your name',
                      controller: formControllers.nameController,
                      focusNode: formControllers.nameFocusNode,
                      isValid: state.name.isValid,
                      isFocused: state.name.isFocused,
                      isTouched: state.name.isTouched,
                      onChanged: (text) {
                        cubit.onNameChanged(text);
                      },
                      onFocusChanged: (focused) {
                        cubit.onNameFocusChanged(focused);
                      },
                    ),
                    const SizedBox(height: 20),
                    ValidatedTextField(
                      title: 'Email',
                      hint: 'Enter your email',
                      controller: formControllers.emailController,
                      focusNode: formControllers.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      isValid: state.email.isValid,
                      isFocused: state.email.isFocused,
                      isTouched: state.email.isTouched,
                      onChanged: (text) {
                        cubit.onEmailChanged(text);
                      },
                      onFocusChanged: (focused) {
                        cubit.onEmailFocusChanged(focused);
                      },
                    ),
                    const SizedBox(height: 20),
                    ValidatedTextField(
                      title: 'Phone',
                      hint: 'Enter your phone number',
                      controller: formControllers.phoneController,
                      focusNode: formControllers.phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      isValid: state.phone.isValid,
                      isFocused: state.phone.isFocused,
                      isTouched: state.phone.isTouched,
                      onChanged: (text) {
                        cubit.onPhoneChanged(text);
                      },
                      onFocusChanged: (focused) {
                        cubit.onPhoneFocusChanged(focused);
                      },
                    ),
                    const SizedBox(height: 20),
                    ValidatedTextField(
                      title: 'Password',
                      hint: 'Enter your password',
                      controller: formControllers.passwordController,
                      focusNode: formControllers.passwordFocusNode,
                      obscureText: true,
                      isValid: state.password.isValid,
                      isFocused: state.password.isFocused,
                      isTouched: state.password.isTouched,
                      onChanged: (text) {
                        cubit.onPasswordChanged(text);
                      },
                      onFocusChanged: (focused) {
                        cubit.onPasswordFocusChanged(focused);
                      },
                    ),
                    const SizedBox(height: 20),
                    ValidatedTextField(
                      title: 'Confirm Password',
                      hint: 'Re-enter your password',
                      controller: formControllers.confirmPasswordController,
                      focusNode: formControllers.confirmPasswordFocusNode,
                      obscureText: true,
                      isValid: state.confirmPassword.isValid,
                      isFocused: state.confirmPassword.isFocused,
                      isTouched: state.confirmPassword.isTouched,
                      onChanged: (text) {
                        cubit.onConfirmPasswordChanged(text);
                      },
                      onFocusChanged: (focused) {
                        cubit.onConfirmPasswordFocusChanged(focused);
                      },
                    ),
                    SizedBox(height: ManagerHeight.h8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: state.isTermsAccepted,
                            onChanged: (value) {
                              cubit.onTermsAcceptedChanged(value ?? false);
                            },
                            activeColor: ManagerColors.primaryColor,
                          ),
                          Text(
                            'Agree With',
                            style: TextStyle(
                              color: ManagerColors.primaryTextColor,
                              fontSize: ManagerFontSizes.s16,
                              fontWeight: ManagerFontWeight.regular,
                            ),
                          ),
                          Text(
                            ' Terms & Conditions',
                            style: TextStyle(
                              color: ManagerColors.primaryColor,
                              fontSize: ManagerFontSizes.s16,
                              fontWeight: ManagerFontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: ManagerColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h40),
                    BaseButton(
                      title: 'Sign Up',
                      isLoading: state.isLoading,
                      onPressed: state.isFormValid && state.isTermsAccepted && !state.isLoading
                          ? () async {
                              final success = await cubit.register(context: context);
                              if (success) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                                showLoginSuccessDialog(context,'Sign Up');
                              }
                            }
                          : null,
                      backgroundColor: state.isFormValid && state.isTermsAccepted
                          ? ManagerColors.primaryColor
                          : const Color(0xFF6A70FF),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
