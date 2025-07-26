import 'package:flutter/material.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';
import '../../domain/product_model.dart';

class ProductDetailsPhotosWidget extends StatelessWidget {
  const ProductDetailsPhotosWidget({
    super.key,
    required this.product,
  });

  final ProductDataModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ManagerHeight.h50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: product.photos.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                ),
                child: Container(
                  width: ManagerWidth.w48,
                  height: ManagerHeight.h48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ManagerWidth.w8,
                    ),
                    border: Border.all(
                      color: Color(0xFFA7A5AF),
                      width: 3,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.photos[index].path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
