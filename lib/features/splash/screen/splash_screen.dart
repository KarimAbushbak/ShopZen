import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/features/out_boarding/screens/out_boarding_screen.dart';
import 'package:shopzen/features/splash/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main_screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startLoading(),

      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const OutBoardingScreen(),
              ),
            );
          } else if (state is SplashGotoHome) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: ManagerColors.primaryColor,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ManagerAssets.splash,
                  height: ManagerHeight.h60,
                  width: ManagerWidth.w60,
                ),
                SizedBox(width: ManagerWidth.w10),
                Text(
                  "ShopZen",
                  style: TextStyle(
                    color: Color(0xffFBFBFC),
                    fontSize: ManagerFontSizes.s40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
