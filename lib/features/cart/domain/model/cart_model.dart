import 'package:shopzen/features/product_details/domain/product_model.dart';


class CartItem {
  final ProductDataModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
