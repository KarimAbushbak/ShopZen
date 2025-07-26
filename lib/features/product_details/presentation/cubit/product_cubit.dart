import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shopzen/features/product_details/data/repo/product_repository.dart';

import '../../domain/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());
  ProductRepository productRepository = ProductRepository();

  Future fetchProductDetails({
    required BuildContext context,
    required int productId,
  }) async {
    final ProductModel productModel = await productRepository.productDetails(
      context: context,
      productId: productId,
    );
    try {
      emit(ProductLoaded(productDetails: productModel.data));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void selectSize(String size) {
    if (state is ProductLoaded) {
      emit((state as ProductLoaded).copyWith(selectedSize: size));
    }

  }

  void selectColor(int index) {
    if (state is ProductLoaded) {
      emit((state as ProductLoaded).copyWith(selectedColorIndex: index));
    }
  }
  void addToCart({
    required int productId,
}){

  }
}
