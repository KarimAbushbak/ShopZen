import '../../domain/models/home_model.dart';
import '../response/home_response.dart';

extension HomeMapper on HomeResponse {
  HomeModel toDomain() {
    return HomeModel(
      data: data
          .map((homeDataResponse) => homeDataResponse.toDomain())
          .toList(),
      success: success,
      status: status,
    );
  }
}

extension HomeDataMapper on HomeDataResponse {
  HomeDataModel toDomain() {
    return HomeDataModel(
      id: id,
      name: name,
      photos: photos,
      thumbnailImage: thumbnailImage,
      basePrice: basePrice,
      baseDiscountedPrice: baseDiscountedPrice,
      todaysDeal: todaysDeal,
      featured: featured,
      unit: unit,
      discount: discount,
      discountType: discountType,
      rating: rating,
      sales: sales,
      links: links?.toDomain(),
    );
  }
}

extension HomeLinksMapper on HomeLinksResponse {
  HomeLinksModel toDomain() {
    return HomeLinksModel(details: details, reviews: reviews, related: related);
  }
}
