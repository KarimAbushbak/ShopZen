import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';
import '../../domain/product_model.dart';
import '../cubit/product_cubit.dart';

class ProductDetailsSizeWidget extends StatelessWidget {
  const ProductDetailsSizeWidget({
    super.key,
    required this.product,
    required this.selectedSize,
  });

  final ProductDataModel product;
  final String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: product.choiceOptions.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select  Size',
            style: TextStyle(
              fontSize: ManagerFontSizes.s16,
              fontWeight: ManagerFontWeight.bold,
              color: ManagerColors.primaryTextColor,
            ),
          ),
          if (product.choiceOptions.isNotEmpty) ...[
            SizedBox(height: ManagerHeight.h16),
            SizedBox(
              height: ManagerHeight.h30,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: product.choiceOptions.first.options.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final productSize = product.choiceOptions.first.options;
                  final size = productSize[index];
                  final isSelected = size == selectedSize;

                  return GestureDetector(
                    onTap: () {
                      context.read<ProductCubit>().selectSize(size);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ManagerWidth.w8),
                        color: isSelected
                            ? ManagerColors.primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Color(0xFFA7A5AF),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w8,
                            vertical: ManagerHeight.h4,
                          ),
                          child: Text(
                            productSize[index],
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s14,
                              fontWeight: ManagerFontWeight.regular,
                              color: isSelected
                                  ? Colors.white
                                  : ManagerColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: ManagerWidth.w12);
                },
              ),
            ),
            SizedBox(height: ManagerHeight.h24),
          ],
        ],
      ),
    );
  }
}
