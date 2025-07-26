import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/resources/manager_assets.dart';
import '../../core/resources/manager_colors.dart';
import '../account/presentation/screens/account_screen.dart';
import '../cart/presentation/screens/cart_screen.dart';
import '../home/presentation/cubit/home_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
import '../saved/screens/saved_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int _currentIndex = 0;

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List <Widget> screens = [
      HomeScreen(),
      SavedScreen(),

      CartScreen(),
      AccountScreen(),
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: ManagerColors.primaryColor,
            unselectedItemColor: Color(0xFF938F9C),
            type: BottomNavigationBarType.fixed,

            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ManagerAssets.homeIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 0 ?
                    ManagerColors.primaryColor : Color(0xFF938F9C),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ManagerAssets.savedIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 1 ?
                    ManagerColors.primaryColor : Color(0xFF938F9C),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ManagerAssets.cartIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 2 ?
                    ManagerColors.primaryColor : Color(0xFF938F9C),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  ManagerAssets.accountIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _currentIndex == 3 ?
                    ManagerColors.primaryColor : Color(0xFF938F9C),
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Account',
              ),
            ],
          ),
          body: screens[_currentIndex],

        );
      },
    );
  }
}
