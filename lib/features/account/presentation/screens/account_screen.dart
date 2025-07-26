import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';

import '../cubit/account_cubit.dart';
import '../widgets/account_page_row.dart';
import 'my_profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
        child: Column(
          children: [
            SizedBox(height: ManagerHeight.h48),
            AccountPageRow(
              title: 'Your Profile',
              iconImage: ManagerAssets.user,
              onPressed: () {
                context.read<AccountCubit>().loadData();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyProfileScreen(),
                  ),
                );
              },
            ),
            AccountPageRow(title: 'My Order', iconImage: ManagerAssets.order),
            AccountPageRow(
              title: 'Payment Methods',
              iconImage: ManagerAssets.credit,
            ),
            AccountPageRow(
              title: 'Notifications',
              iconImage: ManagerAssets.notification,
            ),
            AccountPageRow(
              title: 'Privacy Policy',
              iconImage: ManagerAssets.privacy,
            ),
            AccountPageRow(title: 'Help Center', iconImage: ManagerAssets.help),
            AccountPageRow(
              title: 'Invite Friends',
              iconImage: ManagerAssets.invite,
            ),
          ],
        ),
      ),
    );
  }
}
