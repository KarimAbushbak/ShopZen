import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopzen/core/resources/manager_assets.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/resources/manager_font_sizes.dart';
import 'package:shopzen/core/resources/manager_height.dart';
import 'package:shopzen/core/resources/manager_width.dart';
import 'package:shopzen/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/resources/manager_font_weight.dart';
import '../widgets/home_category_list.dart';
import '../../../../core/widgets/products_grid_view.dart';
import '../widgets/home_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if(state is HomeLoaded){
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: ManagerHeight.h18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                      color: Color(0xFf68656E),
                                      fontSize: ManagerFontSizes.s14,
                                      fontWeight: ManagerFontWeight.regular,
                                    ),
                                  ),
                                  SizedBox(height: ManagerHeight.h4),
                                  Text(
                                    'New York, USA',
                                    style: TextStyle(
                                      color: ManagerColors.primaryTextColor,
                                      fontSize: ManagerFontSizes.s16,
                                      fontWeight: ManagerFontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(ManagerAssets.bell),
                            ],
                          ),
                          SizedBox(height: ManagerHeight.h16),
                          HomeSearchBar(),
                          SizedBox(height: ManagerHeight.h16),
                          Row(
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  color: ManagerColors.primaryTextColor,
                                  fontSize: ManagerFontSizes.s18,
                                  fontWeight: ManagerFontWeight.w800,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    color: Color(0xFF57545B),
                                    fontSize: ManagerFontSizes.s14,
                                    fontWeight: ManagerFontWeight.regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ManagerHeight.h16),
                          HomeCategoryList(),
                          SizedBox(height: ManagerHeight.h24),
                          Container(
                            height: ManagerHeight.h150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage(ManagerAssets.homeBanner),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Hot Deals',
                                style: TextStyle(
                                  color: ManagerColors.primaryTextColor,
                                  fontSize: ManagerFontSizes.s16,
                                  fontWeight: ManagerFontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ManagerHeight.h16),
                        ],
                      ),
                    ),
                  ),
                  ProductGridView(products: state.allProducts)
                  // You can add more SliverToBoxAdapter or SliverList for widgets below the grid
                ],
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
      ),
    );
  }
}
