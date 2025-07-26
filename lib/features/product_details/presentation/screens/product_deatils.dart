import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/core/widgets/base_button.dart';
import 'package:shopzen/features/product_details/domain/product_model.dart';
import 'package:shopzen/features/product_details/presentation/widgets/dot_indicator.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../cubit/product_cubit.dart';
import '../widgets/product_details_photos_widget.dart';
import '../widgets/product_details_size_widget.dart';

class ProductDetails extends StatelessWidget {
  final int productId;
  final VoidCallback onToggleFavorite;

  const ProductDetails({
    super.key,
    required this.productId,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is ProductLoaded) {
          if (state.productDetails.isEmpty) {
            return Center(child: Text('No product details available.'));
          }
          final ProductDataModel product = state.productDetails.first;
          final selectedSize = state.selectedSize;

          return Scaffold(
            appBar: AppBar(title: Text(product.name)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: ManagerHeight.h16),
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: ManagerHeight.h260,
                        child: Image.network(
                          product.thumbnailImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 32,
                        top: 12,
                        child: Container(
                          width: ManagerWidth.w24,
                          height: ManagerHeight.h24,
                          decoration: BoxDecoration(
                            color: Color(0xFFFBFBFC),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoaded) {
                                  final isFavorite = state.favoriteProductIds
                                      .contains(product.id);
                                  // 👈 Debug line

                                  return GestureDetector(
                                    onTap: () {
                                      context.read<HomeCubit>().toggleFavorite(
                                        product.id,
                                      );
                                    },
                                    child: Container(
                                      width: ManagerWidth.w24,
                                      height: ManagerHeight.h24,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFBFBFC),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox(); // fallback while loading or on error
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h16),
                  ProductDetailsPhotosWidget(product: product),
                  SizedBox(height: ManagerHeight.h24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: ManagerFontSizes.s18,
                            fontWeight: ManagerFontWeight.bold,
                            color: ManagerColors.primaryTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        Row(
                          children: [
                            Text(
                              product.calculablePrice.toString(),
                              style: TextStyle(
                                fontSize: ManagerFontSizes.s20,
                                fontWeight: ManagerFontWeight.bold,
                                color: ManagerColors.primaryTextColor,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(ManagerAssets.star),
                                Text(
                                  product.rating.toString(),
                                  style: TextStyle(
                                    fontSize: ManagerFontSizes.s16,
                                    fontWeight: ManagerFontWeight.regular,
                                    color: ManagerColors.primaryTextColor,
                                  ),
                                ),
                                Text(
                                  product.ratingCount.toString(),
                                  style: TextStyle(
                                    fontSize: ManagerFontSizes.s12,
                                    fontWeight: ManagerFontWeight.regular,
                                    color: Color(0xFF68656E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        Text(
                          'Product Details',
                          style: TextStyle(
                            fontSize: ManagerFontSizes.s16,
                            fontWeight: ManagerFontWeight.bold,
                            color: ManagerColors.primaryTextColor,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h8),
                        ReadMoreText(
                          'A durable, lightweight backpack designed for everyday use and travel. Features multiple compartments for organized storage, including a padded laptop sleeve. Made from water-resistant material, it offers comfortable padded shoulder straps and a breathable back panel. Includes a side water bottle pocket and a front zippered pocket for quick access items. Perfect for students, commuters, and travelers seeking functionality and comfort.',
                          style: TextStyle(
                            color: Color(0xFF68656E),
                            fontWeight: ManagerFontWeight.regular,
                            fontSize: ManagerFontSizes.s14,
                          ),
                          trimMode: TrimMode.Line,
                          trimLines: 3,
                          colorClickableText: ManagerColors.primaryColor,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ManagerColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ManagerColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        Divider(),
                        SizedBox(height: ManagerHeight.h16),
                        ProductDetailsSizeWidget(
                          product: product,
                          selectedSize: selectedSize,
                        ),
                        Text(
                          'Select  Color',
                          style: TextStyle(
                            fontSize: ManagerFontSizes.s16,
                            fontWeight: ManagerFontWeight.bold,
                            color: ManagerColors.primaryTextColor,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        DotIndicatorRow(),
                        SizedBox(height: ManagerHeight.h48),
                        BaseButton(
                          title: "Add to Cart",
                          onPressed: () {
                            context.read<CartCubit>().addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to cart')),
                            );
                          },
                        ),
                        SizedBox(height: ManagerHeight.h30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Text(
            'Something went wrong!',
            style: TextStyle(
              color: ManagerColors.primaryTextColor,
              fontSize: ManagerFontSizes.s16,
              fontWeight: ManagerFontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
