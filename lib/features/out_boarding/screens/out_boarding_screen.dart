import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';

import '../../../core/resources/manager_colors.dart';
import '../../../core/resources/manager_width.dart';
import '../../../core/widgets/base_button.dart';
import '../../auth/presentation/screens/choice_screen.dart';

class OutBoardingScreen extends StatelessWidget {
  const OutBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: ManagerHeight.h64),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: SvgPicture.asset(
                ManagerAssets.outBoarding,
                width: 360,
                height: 360,
              ),
            ),
            SizedBox(height: ManagerHeight.h48),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w35),
                  child: Text(
                    'Welcome to ShopZen',
                    style: TextStyle(
                      color: ManagerColors.primaryTextColor,
                      fontSize: ManagerFontSizes.s32,
                      fontWeight: ManagerFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your one-stop destination for hassle-',
                  style: TextStyle(
                    color: Color(0xff68656E),
                    fontSize: ManagerFontSizes.s18,
                    fontWeight: ManagerFontWeight.regular,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'free online shopping',
                  style: TextStyle(
                    color: Color(0xff68656E),
                    fontSize: ManagerFontSizes.s18,
                    fontWeight: ManagerFontWeight.regular,
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h64),
            BaseButton(
              title: 'Get Started',
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ChoiceScreen(),
                  ),
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}

