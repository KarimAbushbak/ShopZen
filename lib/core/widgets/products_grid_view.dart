import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/manager_assets.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_sizes.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_width.dart';
import '../../features/product_details/presentation/cubit/product_cubit.dart';
import '../../features/product_details/presentation/screens/product_deatils.dart';
import '../../features/home/domain/models/home_model.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

class ProductGridView extends StatelessWidget {
  final List<HomeDataModel> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) return const SizedBox();

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final product = products[index];
                final isFavorite = state.favoriteProductIds.contains(product.id);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: context.read<HomeCubit>()),
                            BlocProvider(
                              create: (_) => ProductCubit()
                                ..fetchProductDetails(
                                  context: context,
                                  productId: product.id,
                                ),
                            ),
                          ],
                          child: ProductDetails(
                            productId: product.id,
                            onToggleFavorite: () {
                              context.read<HomeCubit>().toggleFavorite(product.id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: ManagerHeight.h294,
                        width: ManagerWidth.w160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.thumbnailImage,
                                    fit: BoxFit.cover,
                                    height: ManagerHeight.h186,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<HomeCubit>().toggleFavorite(product.id);
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
                                          color: isFavorite ? Colors.red : Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h16),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  color: ManagerColors.primaryTextColor,
                                  fontSize: ManagerFontSizes.s16,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        product.basePrice.toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF323135),
                                          fontSize: ManagerFontSizes.s16,
                                          fontWeight: ManagerFontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: ManagerWidth.w8),
                                      Text(
                                        '\$49.99',
                                        style: TextStyle(
                                          color: const Color(0xFF68656E),
                                          fontSize: ManagerFontSizes.s14,
                                          fontWeight: ManagerFontWeight.w400,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: const Color(0xFF68656E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ManagerHeight.h8),
                                  Row(
                                    children: [
                                      SvgPicture.asset(ManagerAssets.star),
                                      SizedBox(width: ManagerWidth.w8),
                                      Text(
                                        '4.8 (120)',
                                        style: TextStyle(
                                          color: const Color(0xFF68656E),
                                          fontSize: ManagerFontSizes.s16,
                                          fontWeight: ManagerFontWeight.regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: products.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: ManagerHeight.h24,
              crossAxisSpacing: ManagerWidth.w16,
              childAspectRatio: 0.544,
            ),
          ),
        );
      },
    );
  }
}
