import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../product_details/domain/product_model.dart';
import '../../domain/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final List<CartItem> _cartItems = [];

  CartCubit() : super(CartInitial());

  void addToCart(ProductDataModel product) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (index != -1) {
      _cartItems[index].quantity += 1; // increment if already in cart
    } else {
      _cartItems.add(CartItem(product: product));
    }
    emit(CartUpdated(cartItems: List.from(_cartItems)));
  }

  void removeFromCart(ProductDataModel product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);

    emit(CartUpdated(cartItems: List.from(_cartItems)));
  }

  void increaseQuantity(int productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      _cartItems[index].quantity += 1;
      emit(CartUpdated(cartItems: List.from(_cartItems)));
    }
  }

  void decreaseQuantity(int productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity -= 1;
      emit(CartUpdated(cartItems: List.from(_cartItems)));
    }
  }
}
