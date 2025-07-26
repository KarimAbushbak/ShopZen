import 'package:shopzen/core/extensions/extensions.dart';

import '../../domain/product_model.dart';
import '../response/product_response.dart';

extension ProductMapper on ProductResponse {
  ProductModel toDomain() {
    return ProductModel(
        data:
        data!.map((homeDataResponse) => homeDataResponse.toDomain()).toList(),
        success: success.onNull(),
        status: status.onNull());
  }
}


extension ProductDataMapper on ProductDataResponse{
  ProductDataModel toDomain() {
    return ProductDataModel(id: id.onNull(),
        name: name.onNull(),
        addedBy: addedBy.onNull(),
        sellerId: sellerId.onNull(),
        shopId: shopId.onNull(),
        shopName: shopName.onNull(),
        shopLogo: shopLogo.onNull(),
        photos:
        photos!.map((productPhotoResponse) => productPhotoResponse.toDomain()).toList(),
        thumbnailImage: thumbnailImage.onNull(),
        tags: tags.onNull(),
        choiceOptions:
        choiceOptions!.map((choiceOptionsResponse) => choiceOptionsResponse.toDomain()).toList(),
        hasDiscount: hasDiscount.onNull(),
        strokedPrice: strokedPrice.onNull(),
        mainPrice: mainPrice.onNull(),
        calculablePrice: calculablePrice.onNull(),
        currencySymbol: currencySymbol.onNull(),
        currentStock: currentStock.onNull(),
        unit: unit.onNull(),
        rating: rating.onNull(),
        ratingCount: ratingCount.onNull(),
        earnPoint: earnPoint.onNull(),
        videoLink: videoLink.onNull(),
        brand:
        brand!.toDomain(),
        link: link.onNull()
    );
  }
}


extension ProductPhotosMapper on ProductPhotosResponse {
  ProductPhotosModel toDomain() {
    return ProductPhotosModel(variant: variant.onNull(), path: path.onNull());
  }
}
extension ChoiceOptionsMapper on ChoiceOptionsResponse {
  ChoiceOptionsModel toDomain() {
    return ChoiceOptionsModel(
        name: name.onNull(), title: title.onNull(), options: options.onNull());
  }
}


extension BrandMapper on BrandResponse {
  BrandModel toDomain() {
    return BrandModel(
        id: id.onNull(), name: name.onNull(), logo: logo.onNull());
  }
}