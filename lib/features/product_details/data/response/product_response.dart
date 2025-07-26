class ProductResponse {
  final List<ProductDataResponse>? data;
  final bool? success;
  final int? status;

  ProductResponse({this.data, this.success, this.status});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e))
          .toList(),
      success: json['success'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'success': success,
    'status': status,
  };
}

class ProductDataResponse {
  final int? id;
  final String? name;
  final String? addedBy;
  final int? sellerId;
  final int? shopId;
  final String? shopName;
  final String? shopLogo;
  final List<ProductPhotosResponse>? photos;
  final String? thumbnailImage;
  final List<String>? tags;
  final List<ChoiceOptionsResponse>? choiceOptions;
  final bool? hasDiscount;
  final String? strokedPrice;
  final String? mainPrice;
  final int? calculablePrice;
  final String? currencySymbol;
  final int? currentStock;
  final String? unit;
  final int? rating;
  final int? ratingCount;
  final int? earnPoint;
  final String? videoLink;
  final BrandResponse? brand;
  final String? link;

  ProductDataResponse({
    this.id,
    this.name,
    this.addedBy,
    this.sellerId,
    this.shopId,
    this.shopName,
    this.shopLogo,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.choiceOptions,
    this.hasDiscount,
    this.strokedPrice,
    this.mainPrice,
    this.calculablePrice,
    this.currencySymbol,
    this.currentStock,
    this.unit,
    this.rating,
    this.ratingCount,
    this.earnPoint,
    this.videoLink,
    this.brand,
    this.link,
  });

  factory ProductDataResponse.fromJson(Map<String, dynamic> json) {
    return ProductDataResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'],
      addedBy: json['added_by'],
      sellerId: (json['seller_id'] as num?)?.toInt(),
      shopId: (json['shop_id'] as num?)?.toInt(),
      shopName: json['shop_name'],
      shopLogo: json['shop_logo'],
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => ProductPhotosResponse.fromJson(e))
          .toList(),
      thumbnailImage: json['thumbnail_image'],
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      choiceOptions: (json['choice_options'] as List<dynamic>?)
          ?.map((e) => ChoiceOptionsResponse.fromJson(e))
          .toList(),
      hasDiscount: json['has_discount'],
      strokedPrice: json['stroked_price'],
      mainPrice: json['main_price'],
      calculablePrice: (json['calculable_price'] as num?)?.toInt(),
      currencySymbol: json['currency_symbol'],
      currentStock: (json['current_stock'] as num?)?.toInt(),
      unit: json['unit'],
      rating: (json['rating'] as num?)?.toInt(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
      earnPoint: (json['earn_point'] as num?)?.toInt(),
      videoLink: json['video_link'],
      brand: json['brand'] != null ? BrandResponse.fromJson(json['brand']) : null,
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'added_by': addedBy,
    'seller_id': sellerId,
    'shop_id': shopId,
    'shop_name': shopName,
    'shop_logo': shopLogo,
    'photos': photos?.map((e) => e.toJson()).toList(),
    'thumbnail_image': thumbnailImage,
    'tags': tags,
    'choice_options': choiceOptions?.map((e) => e.toJson()).toList(),
    'has_discount': hasDiscount,
    'stroked_price': strokedPrice,
    'main_price': mainPrice,
    'calculable_price': calculablePrice,
    'currency_symbol': currencySymbol,
    'current_stock': currentStock,
    'unit': unit,
    'rating': rating,
    'rating_count': ratingCount,
    'earn_point': earnPoint,
    'video_link': videoLink,
    'brand': brand?.toJson(),
    'link': link,
  };
}

class ProductPhotosResponse {
  final String? variant;
  final String? path;

  ProductPhotosResponse({this.variant, this.path});

  factory ProductPhotosResponse.fromJson(Map<String, dynamic> json) {
    return ProductPhotosResponse(
      variant: json['variant'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() => {
    'variant': variant,
    'path': path,
  };
}

class ChoiceOptionsResponse {
  final String? name;
  final String? title;
  final List<String>? options;

  ChoiceOptionsResponse({this.name, this.title, this.options});

  factory ChoiceOptionsResponse.fromJson(Map<String, dynamic> json) {
    return ChoiceOptionsResponse(
      name: json['name'],
      title: json['title'],
      options: (json['options'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'options': options,
  };
}

class BrandResponse {
  final int? id;
  final String? name;
  final String? logo;

  BrandResponse({this.id, this.name, this.logo});

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo': logo,
  };
}
