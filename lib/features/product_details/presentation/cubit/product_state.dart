part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

// Add to your ProductState (or create a new state if needed)
class ProductLoaded extends ProductState {
  final List<ProductDataModel> productDetails;
  final String? selectedSize; // Add this line
  final int? selectedColorIndex;
  final List<ProductDataModel>? cartItems;



  ProductLoaded({required this.productDetails, this.selectedSize, this.selectedColorIndex, this.cartItems});

  ProductLoaded copyWith({
    List<ProductDataModel>? productDetails,
    String? selectedSize,
    int? selectedColorIndex,
    List<ProductDataModel>? cartItems,
  }) {
    return ProductLoaded(
      productDetails: productDetails ?? this.productDetails,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
