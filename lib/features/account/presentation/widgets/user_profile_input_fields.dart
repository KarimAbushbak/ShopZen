import 'package:flutter/material.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_height.dart';

class UserProfileInputFields extends StatelessWidget {
  const UserProfileInputFields({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ManagerFontSizes.s16,
            fontWeight: FontWeight.bold,
            color: ManagerColors.primaryTextColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E5),
                width: 1.0,
              ),
            ),
            hintText: hintText,
            enabled: enabled,
          ),
        ),
        SizedBox(height: ManagerHeight.h16),
      ],
    );
  }
}
