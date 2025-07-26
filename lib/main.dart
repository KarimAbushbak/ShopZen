import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/features/account/presentation/cubit/account_cubit.dart';
import 'package:shopzen/features/splash/screen/splash_screen.dart';

import 'core/constants.dart';
import 'core/storage/local/datatbase/app_settings_shared_preferences.dart';
import 'core/storage/local/datatbase/user_preference_controller.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsSharedPreferences().initPreferences();
  await UserPreferenceController().initSharedPreferences();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..fetchProducts(context: context),
        ),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AccountCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: Size(
        Constants.designDeviceWidth,
        Constants.designDeviceHeight,
      ),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: ManagerFontSizes.s24,
                fontWeight: FontWeight.bold,
                color: ManagerColors.primaryTextColor,
              ),
              centerTitle: true
            ),

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
