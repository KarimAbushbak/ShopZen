import 'package:flutter/material.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_sizes.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_width.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ManagerColors.primaryColor,
        minimumSize: Size(ManagerWidth.w355, ManagerHeight.h50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      child: isLoading
          ? SizedBox(
              width: ManagerWidth.w24,
              height: ManagerHeight.h24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ))
          : Text(
              title,
              style: TextStyle(
                color: Color(0xffFBFBFC),
                fontSize: ManagerFontSizes.s16,
                fontWeight: ManagerFontWeight.bold,
              ),
            ),
    );
  }
}
