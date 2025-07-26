import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/core/widgets/base_button.dart';
import 'package:shopzen/features/account/presentation/cubit/account_cubit.dart';
import 'package:shopzen/features/account/presentation/widgets/user_profile_input_fields.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is! AccountLoaded) return const SizedBox();

          final nameController = TextEditingController(text: state.name);
          final emailController = TextEditingController(text: state.email);
          final dateOfBirthController = TextEditingController(
            text: state.dateOfBirth,
          );
          final genderController = TextEditingController(text: state.gender);
          final phoneController = TextEditingController(
            text: state.phoneNumber,
          );

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ManagerHeight.h24),
                UserProfileInputFields(
                  controller: nameController,
                  title: 'Name',
                  hintText: 'Enter your name',
                ),
                UserProfileInputFields(
                  controller: emailController,
                  title: 'Email',
                  hintText: 'Enter your Email',
                  enabled: false,
                ),
                UserProfileInputFields(
                  controller: dateOfBirthController,
                  title: 'Date of Birth',
                  hintText: 'Enter your Date of Birth',
                ),
                UserProfileInputFields(
                  controller: genderController,
                  title: 'Gender',
                  hintText: 'Enter your Gender',
                ),
                UserProfileInputFields(
                  controller: phoneController,
                  title: 'Phone Number',
                  hintText: 'Enter your Phone Number',
                ),

                SizedBox(height: ManagerHeight.h16),
                BaseButton(
                  title: 'Save',
                  onPressed: () {
                    context.read<AccountCubit>().updateUserInfo(
                      name: nameController.text,
                      phone: phoneController.text,
                      dateOfBirth: dateOfBirthController.text,
                      gender: genderController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
