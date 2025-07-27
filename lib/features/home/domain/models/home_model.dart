class HomeModel {
  final List<HomeDataModel> data;
  final bool success;
  final int status;

  HomeModel({required this.data, required this.success, required this.status});
}

class HomeDataModel {
  final int id;
  final String name;
  final List<String> photos;
  final String thumbnailImage;
  final double basePrice;
  final double baseDiscountedPrice;
  final int todaysDeal;
  final int featured;
  final String unit;
  final int discount;
  final String discountType;
  final int rating;
  final int sales;
  final HomeLinksModel? links;

  HomeDataModel({
    required this.id,
    required this.name,
    required this.photos,
    required this.thumbnailImage,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.todaysDeal,
    required this.featured,
    required this.unit,
    required this.discount,
    required this.discountType,
    required this.rating,
    required this.sales,
    required this.links,
  });
}

class HomeLinksModel {
  final String details;
  final String reviews;
  final String related;

  HomeLinksModel({
    required this.details,
    required this.reviews,
    required this.related,
  });
}
