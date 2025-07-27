import 'package:shopzen/core/extensions/extensions.dart';

class HomeResponse {
  List<HomeDataResponse> data;
  bool success;
  int status;

  HomeResponse({
    required this.data,
    required this.success,
    required this.status,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => HomeDataResponse.fromJson(e))
              .toList() ??
          [],
      success: json['success'] as bool? ?? false,
      status: json['status'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'success': success,
      'status': status,
    };
  }
}

class HomeDataResponse {
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
  final HomeLinksResponse? links;

  HomeDataResponse({
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
    this.links,
  });

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) {
    return HomeDataResponse(
      id: (json['id'] as int?).onNull(),
      name: (json['name'] as String?).onNull(),
      photos: (json['photos'] as List?)!
          .map((e) => e.toString())
          .toList()
          .onNull(),
      thumbnailImage: (json['thumbnail_image'] as String?).onNull(),
      basePrice: double.tryParse(json['base_price'].toString()).onNull(),
      baseDiscountedPrice: double.tryParse(
        json['base_discounted_price'].toString(),
      ).onNull(),
      todaysDeal: (json['todays_deal'] as int?).onNull(),
      featured: (json['featured'] as int?).onNull(),
      unit: (json['unit'] as String?).onNull(),
      discount: (json['discount'] as int?).onNull(),
      discountType: (json['discount_type'] as String?).onNull(),
      rating: (json['rating'] as int?).onNull(),
      sales: (json['sales'] as int?).onNull(),
      links: json['links'] != null
          ? HomeLinksResponse.fromJson(json['links'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photos': photos,
      'thumbnail_image': thumbnailImage,
      'base_price': basePrice,
      'base_discounted_price': baseDiscountedPrice,
      'todays_deal': todaysDeal,
      'featured': featured,
      'unit': unit,
      'discount': discount,
      'discount_type': discountType,
      'rating': rating,
      'sales': sales,
      if (links != null) 'links': links!.toJson(),
    };
  }
}

class HomeLinksResponse {
  String details;
  String reviews;
  String related;

  HomeLinksResponse({
    required this.details,
    required this.reviews,
    required this.related,
  });

  factory HomeLinksResponse.fromJson(Map<String, dynamic> json) {
    return HomeLinksResponse(
      details: (json['details'] as String?).onNull(),
      reviews: (json['reviews'] as String?).onNull(),
      related: (json['related'] as String?).onNull(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    data['reviews'] = reviews;
    data['related'] = related;
    return data;
  }
}
