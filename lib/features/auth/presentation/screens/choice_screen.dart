import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/core/widgets/base_button.dart';
import 'package:shopzen/features/auth/presentation/screens/signup_screen.dart';

import 'login_screen.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: ManagerHeight.h24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: Text(
                    'Login to ShopZen',
                    style: TextStyle(
                      color: ManagerColors.primaryTextColor,
                      fontSize: ManagerFontSizes.s32,
                      fontWeight: ManagerFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h48),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: Size(ManagerWidth.w355, ManagerHeight.h50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xFFDAE2FF), width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ManagerAssets.google),
                    SizedBox(width: ManagerWidth.w8),
                    Text(
                      'Login with Google',
                      style: TextStyle(
                        color: ManagerColors.primaryTextColor,
                        fontSize: ManagerFontSizes.s16,
                        fontWeight: ManagerFontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: Size(ManagerWidth.w355, ManagerHeight.h50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xFFDAE2FF), width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ManagerAssets.apple),
                    SizedBox(width: ManagerWidth.w8),
                    Text(
                      'Login with Apple',
                      style: TextStyle(
                        color: ManagerColors.primaryTextColor,
                        fontSize: ManagerFontSizes.s16,
                        fontWeight: ManagerFontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h48),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "Or",
                  style: TextStyle(
                    color: Color(0xFF938F9C),
                    fontWeight: FontWeight.w500,
                    fontSize: ManagerFontSizes.s16,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                    endIndent: 20,
                    indent: 10,
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h48),
            BaseButton(
              title: 'Login With Email',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                );
              },
            ),
            SizedBox(height: ManagerHeight.h350),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have any account yet?',
                  style: TextStyle(
                    color: Color(0xFF68656E),
                    fontSize: ManagerFontSizes.s16,
                    fontWeight: ManagerFontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: ManagerColors.primaryColor,
                      fontSize: ManagerFontSizes.s16,
                      fontWeight: ManagerFontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
