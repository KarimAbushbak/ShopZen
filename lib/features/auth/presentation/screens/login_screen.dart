import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/features/main_screen/main_screen.dart';
import '../../../../core/widgets/base_button.dart';
import '../../../../core/widgets/valideted_text_field.dart';
import '../cubit/login_form_cubit.dart';
import '../../data/repos/auth_repository.dart';
import '../widget/show_login_success_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginFormCubit(authRepository: AuthRepository()),
      child: BlocBuilder<LoginFormCubit, LoginFormState>(
        builder: (context, state) {
          final cubit = context.read<LoginFormCubit>();
          return Scaffold(
            body: SafeArea(
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
                          'Login With Email',
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
                    title: 'Email',

                    hint: 'Enter your email',
                    controller: emailController,
                    focusNode: emailFocusNode,
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
                    title: 'Password',
                    hint: 'Enter your password',
                    controller: passwordController,
                    focusNode: passwordFocusNode,
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
                  SizedBox(height: ManagerHeight.h8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: ManagerColors.primaryTextColor,
                            fontSize: ManagerFontSizes.s16,
                            fontWeight: ManagerFontWeight.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h48),
                  BaseButton(
                    title: 'Login',
                    isLoading: state.isLoading,

                    onPressed: state.isFormValid

                        ? () async {
                            final success = await cubit.login(context: context);
                            if (success) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                              showLoginSuccessDialog(context,'Login');
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setBool('is_logged_in', true);

                            }
                          }
                        : null,
                    backgroundColor: state.isFormValid
                        ? ManagerColors.primaryColor
                        : const Color(0xFF6A70FF),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
