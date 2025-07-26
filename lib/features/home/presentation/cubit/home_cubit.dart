import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shopzen/features/home/data/repos/home_repository.dart';
import 'package:shopzen/features/home/domain/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());
  HomeRepository homeRepository = HomeRepository();

  Future fetchProducts({required BuildContext context}) async {
    try {
      final HomeModel homeModel = await homeRepository.home(context: context);

      List<HomeDataModel> featuredProducts = [];
      List<HomeDataModel> discountedProducts = [];

      for (HomeDataModel item in homeModel.data) {
        if (item.featured == 1) {
          featuredProducts.add(item);
        }
        if (item.discount > 0) {
          discountedProducts.add(item);
        }
      }

      emit(HomeLoaded(
        allProducts: homeModel.data,
        featuredProducts: featuredProducts,
        discountedProducts: discountedProducts,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void toggleFavorite(int productId) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final currentFavorites = Set<int>.from(currentState.favoriteProductIds);
      if (currentFavorites.contains(productId)) {
        currentFavorites.remove(productId);
      } else {
        currentFavorites.add(productId);
      }
      emit(currentState.copyWith(favoriteProductIds: currentFavorites));
    }
  }
}
