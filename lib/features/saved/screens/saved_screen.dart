import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_weight.dart';
import 'package:shopzen/core/resources/manager_height.dart';

import '../../../core/resources/manager_font_sizes.dart';
import '../../../core/widgets/products_grid_view.dart';
import '../../home/presentation/cubit/home_cubit.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Items')),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            final favoriteIds = state.favoriteProductIds;
            final favoriteProducts = state.allProducts
                .where((product) => favoriteIds.contains(product.id))
                .toList();
            if (favoriteProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ManagerAssets.emptyFavorite),
                    SizedBox(height: ManagerHeight.h24),
                    Text(
                      'No Saved Items',
                      style: TextStyle(
                        color: ManagerColors.primaryTextColor,
                        fontSize: ManagerFontSizes.s20,
                        fontWeight: ManagerFontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don’t have any saved items.',
                          style: TextStyle(
                            color: Color(0xff68656E),
                            fontSize: ManagerFontSizes.s16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Go to home and add some.',
                          style: TextStyle(
                            color: Color(0xff68656E),
                            fontSize: ManagerFontSizes.s16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          '${favoriteProducts.length} Items',
                          style: TextStyle(
                            color: Color(0xFF68656E),
                            fontSize: ManagerFontSizes.s18,
                          ),
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h16,)
                    ],
                  ),
                ),
                ProductGridView(products: favoriteProducts),
                // This should return a sliver
              ],
            );
          }
          return Column(
            children: [
              Center(
                child: Text(
                  '8 Items',
                  style: TextStyle(
                    color: Color(0xFF68656E),
                    fontSize: ManagerFontSizes.s18,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
