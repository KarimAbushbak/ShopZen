import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';

import '../../../../core/resources/manager_assets.dart';


class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFBFBFC),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(
              alpha: 0.1
            ),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
        ),
        child: Row(
          children: [
            SvgPicture.asset(ManagerAssets.search),
            SizedBox(width: ManagerWidth.w16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find your favorite items',
                  hintStyle: TextStyle(
                    color: Color(0xFF7F7B87),
                    fontSize: ManagerFontSizes.s14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SvgPicture.asset(ManagerAssets.searchVisual),
          ],
        ),
      ),
    );
  }
}
