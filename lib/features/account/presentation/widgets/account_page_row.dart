import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_height.dart';

import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_width.dart';

class AccountPageRow extends StatelessWidget {
  final String title;
  final String iconImage;
  final VoidCallback? onPressed;

  const AccountPageRow({
    super.key,
    required this.title,
    required this.iconImage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconImage,
              width: ManagerWidth.w24,
              height: ManagerHeight.h24,
            ),
            SizedBox(width: ManagerWidth.w12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ManagerFontSizes.s16,
                  fontWeight: ManagerFontWeight.regular,
                  color: ManagerColors.primaryTextColor,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ManagerColors.primaryTextColor,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
        SizedBox(height: ManagerHeight.h10),
        Divider(color: Color(0xFFE0E0E5), height: 1, thickness: 1),
        SizedBox(height: ManagerHeight.h20),
      ],
    );
  }
}
