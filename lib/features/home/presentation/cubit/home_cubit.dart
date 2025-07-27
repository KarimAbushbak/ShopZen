import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shopzen/features/home/data/repos/home_repository.dart';
import 'package:shopzen/features/home/domain/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());
  HomeRepository homeRepository = HomeRepository();

  Future<void> fetchProducts() async {
    emit(HomeLoading());

    try {
      final HomeModel homeModel = await homeRepository.fetchHomeData();

      final allProducts = homeModel.data;

      final featuredProducts = allProducts
          .where((item) => item.featured == 1)
          .toList();

      final discountedProducts = allProducts
          .where((item) => item.discount > 0)
          .toList();

      emit(
        HomeLoaded(
          allProducts: allProducts,
          featuredProducts: featuredProducts,
          discountedProducts: discountedProducts,
        ),
      );
    } on Exception catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void toggleFavorite(int productId) {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    final currentFavorites = Set<int>.from(currentState.favoriteProductIds);

    currentFavorites.contains(productId)
        ? currentFavorites.remove(productId)
        : currentFavorites.add(productId);

    emit(currentState.copyWith(favoriteProductIds: currentFavorites));
  }
}
