class ProductModel {
  final List<ProductDataModel> data;
  final bool success;
  final int status;

  ProductModel({
    required this.data,
   required this.success,
   required this.status});
}

class ProductDataModel {
  final int id;
  final String name;
  final String addedBy;
  final int sellerId;
  final int shopId;
  final String shopName;
  final String shopLogo;
  final List<ProductPhotosModel> photos;
  final String thumbnailImage;
  final List<String> tags;
  final List<ChoiceOptionsModel> choiceOptions;
  final bool hasDiscount;
  final String strokedPrice;
  final String mainPrice;
  final int calculablePrice;
  final String currencySymbol;
  final int currentStock;
  final String unit;
  final int rating;
  final int ratingCount;
  final int earnPoint;
  final String videoLink;
  final BrandModel brand;
  final String link;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.addedBy,
    required this.sellerId,
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.photos,
    required this.thumbnailImage,
    required this.tags,
    required this.choiceOptions,
    required this.hasDiscount,
    required this.strokedPrice,
    required this.mainPrice,
    required this.calculablePrice,
    required this.currencySymbol,
    required this.currentStock,
    required this.unit,
    required this.rating,
    required this.ratingCount,
    required this.earnPoint,
    required this.videoLink,
    required this.brand,
    required this.link,
  });
}

class ProductPhotosModel {
  final String variant;
  final String path;

  ProductPhotosModel({required this.variant,required this.path});

}

class ChoiceOptionsModel {
  final String name;
  final String title;
  final List<String> options;

  ChoiceOptionsModel({ required this.name,required this.title,required this.options});

}

class BrandModel {
  final int id;
  final String name;
  final String logo;

  BrandModel({required this.id,required this.name,required this.logo});


}
