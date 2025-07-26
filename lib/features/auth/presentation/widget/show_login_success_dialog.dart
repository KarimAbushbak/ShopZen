import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/core/widgets/base_button.dart';

void showLoginSuccessDialog(BuildContext context, String title) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SizedBox(
        height: ManagerHeight.h350,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: SvgPicture.asset(
                 ManagerAssets.success,
                  height: ManagerHeight.h64,
                  width: ManagerWidth.w64,
                ),
              ),
              const SizedBox(height: 22),
               Text(
                '$title Successful!',
                style: TextStyle(fontSize: ManagerFontSizes.s24, fontWeight: FontWeight.bold,color: ManagerColors.primaryTextColor),
              ),
               SizedBox(height: ManagerHeight.h48),
              BaseButton(
                title: 'Done',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
