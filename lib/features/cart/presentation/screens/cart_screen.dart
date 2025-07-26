import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopzen/core/resources/manager_colors.dart';
import 'package:shopzen/core/widgets/base_button.dart';
import 'package:shopzen/features/cart/presentation/widget/remove_item_from_cart_dialog.dart';
import '../../../../core/resources/manager_assets.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_font_weight.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';
import '../cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            if (state.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ManagerAssets.cart),
                    SizedBox(height: ManagerHeight.h24),
                    Text(
                      'Your Cart is Empty',
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
                          'When you add products, they’ll',
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
                          '  appear here.',
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
            final subtotal = state.cartItems.fold<double>(
              0.0,
              (sum, item) =>
                  sum + (item.product.calculablePrice * item.quantity),
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                      final product = cartItem.product;

                      return Column(
                        children: [
                          Slidable(
                            key: ValueKey(product.id),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              extentRatio: 0.2,
                              children: [
                                CustomSlidableAction(
                                  onPressed: (_) {
                                    removeItemFromCartDialog(context, 'title', product);
                                  },
                                  backgroundColor: const Color(0xFFFFE5E8),
                                  autoClose: true,
                                  child: Center(
                                    child:SvgPicture.asset(
                                      ManagerAssets.delete,
                                      width: ManagerWidth.w24,
                                      height: ManagerHeight.h24,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w20,
                                vertical: ManagerHeight.h16,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: ManagerWidth.w80,
                                    height: ManagerHeight.h80,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        ManagerWidth.w10,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          product.thumbnailImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: ManagerWidth.w16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: ManagerWidth.w16,
                                            fontWeight:
                                                ManagerFontWeight.regular,
                                          ),
                                        ),
                                        SizedBox(height: ManagerHeight.h8),
                                        Row(
                                          children: [
                                            Text(
                                              '\$${product.calculablePrice.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: ManagerWidth.w16,
                                                color: ManagerColors
                                                    .primaryTextColor,
                                                fontWeight:
                                                    ManagerFontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: ManagerWidth.w22,
                                              height: ManagerHeight.h22,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE0E0E5),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),

                                              child: Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .decreaseQuantity(
                                                          product.id,
                                                        );
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: ManagerWidth.w10,
                                              ),
                                              child: Text(
                                                cartItem.quantity.toString(),
                                                style: TextStyle(
                                                  fontSize: ManagerWidth.w16,
                                                  color: ManagerColors
                                                      .primaryTextColor,
                                                  fontWeight:
                                                      ManagerFontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ManagerWidth.w22,
                                              height: ManagerHeight.h22,
                                              decoration: BoxDecoration(
                                                color:
                                                    ManagerColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),

                                              child: Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .increaseQuantity(
                                                          product.id,
                                                        );
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
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
                          Divider(color: Color(0xFFE0E0E5), height: 1),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: ManagerHeight.h30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub-total: ',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: Color(0xFF57545B),
                            ),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: ManagerColors.primaryTextColor,
                              fontWeight: ManagerFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee: ',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: Color(0xFF57545B),
                            ),
                          ),
                          Text(
                            '\$20.00',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: ManagerColors.primaryTextColor,
                              fontWeight: ManagerFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount: ',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: Color(0xFF57545B),
                            ),
                          ),
                          Text(
                            '\$10',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: ManagerColors.primaryTextColor,
                              fontWeight: ManagerFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      DottedLine(
                        dashLength: 4.0,
                        dashGapLength: 4.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.shade300,
                      ),
                      SizedBox(height: ManagerHeight.h16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              fontWeight: ManagerFontWeight.w600,
                              color: ManagerColors.primaryTextColor,
                            ),
                          ),
                          Text(
                            '\$${state.cartItems.fold(0, (total, item) => total + item.product.calculablePrice * item.quantity - 30).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: ManagerFontSizes.s16,
                              color: ManagerColors.primaryTextColor,
                              fontWeight: ManagerFontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h40),
                      BaseButton(title: 'Go to Checkout', onPressed: () {}),
                      SizedBox(height: ManagerHeight.h40),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ManagerAssets.cart),
                SizedBox(height: ManagerHeight.h24),
                Text(
                  'Your Cart is Empty',
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
                      'When you add products, they’ll',
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
                      '  appear here.',
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
        },
      ),
    );
  }
}
