part of 'cart_cubit.dart';


@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartUpdated extends CartState {
  final List<CartItem> cartItems;

  CartUpdated({
    required this.cartItems,
  });
}
