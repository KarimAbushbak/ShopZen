import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/features/product_details/domain/product_model.dart';

import '../cubit/cart_cubit.dart';

void removeItemFromCartDialog(BuildContext context,
    String title,
    ProductDataModel product,) {
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
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: ManagerHeight.h20),
                child: Text(
                  'Remove from Cart',
                  style: TextStyle(
                    color: ManagerColors.primaryTextColor,
                    fontSize: ManagerFontSizes.s20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: ManagerHeight.h16),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: ManagerHeight.h24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: ManagerWidth.w80,
                    height: ManagerHeight.h80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(product.thumbnailImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            color: ManagerColors.primaryTextColor,
                            fontSize: ManagerFontSizes.s16,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ManagerHeight.h4),
                        Text(
                          '\$${product.calculablePrice}',
                          style: TextStyle(
                            color: ManagerColors.primaryTextColor,
                            fontSize: ManagerFontSizes.s16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ManagerHeight.h48),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEEEEF1),

                      fixedSize: Size(ManagerWidth.w160, ManagerHeight.h50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: ManagerColors.primaryTextColor,
                        fontSize: ManagerFontSizes.s16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDE1135),

                      fixedSize: Size(ManagerWidth.w160, ManagerHeight.h50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.read<CartCubit>().removeFromCart(product);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Item removed from cart',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 16,
                              vertical: 20),
                        ),
                      );

                    },
                    child: Text(
                      'Yes, Remove',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ManagerFontSizes.s16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
