part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoaded extends HomeState {
  final List<HomeDataModel> allProducts;
  final List<HomeDataModel> featuredProducts;
  final List<HomeDataModel> discountedProducts;
  final Set<int> favoriteProductIds;

  HomeLoaded({
    required this.allProducts,
    required this.featuredProducts,
    required this.discountedProducts,
    this.favoriteProductIds = const {},
  });

  HomeLoaded copyWith({
    List<HomeDataModel>? allProducts,
    List<HomeDataModel>? featuredProducts,
    List<HomeDataModel>? discountedProducts,
    Set<int>? favoriteProductIds,
  }) {
    return HomeLoaded(
      allProducts: allProducts ?? this.allProducts,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      discountedProducts: discountedProducts ?? this.discountedProducts,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds ,
    );
  }
}
final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
