import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';

import '../../../../core/resources/manager_assets.dart';
import '../../../../core/resources/manager_font_weight.dart';
class HomeCategoryList extends StatelessWidget {
  HomeCategoryList({super.key});

  final List<Map<String, String>> categories = [
    {'name': 'Fashion', 'icon': ManagerAssets.category1},
    {'name': 'Fitness', 'icon': ManagerAssets.category2},
    {'name': 'Living', 'icon': ManagerAssets.category3},
    {'name': 'Games', 'icon': ManagerAssets.category4},
    {'name': 'Stationery', 'icon': ManagerAssets.category5},
    {'name': 'Fashion', 'icon': ManagerAssets.category1},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ManagerHeight.h80,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.only(right: ManagerWidth.w16),
            child: Column(
              children: [
                Container(
                  width: ManagerWidth.w48,
                  height: ManagerHeight.h48,
                  decoration: BoxDecoration(
                    color: Color(0xFFEBEFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: SvgPicture.asset(category['icon']!)),
                ),
                SizedBox(height: ManagerHeight.h8),
                Text(
                  category['name']!,
                  style: TextStyle(
                    color: ManagerColors.primaryTextColor,
                    fontSize: ManagerFontSizes.s14,
                    fontWeight: ManagerFontWeight.regular,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
