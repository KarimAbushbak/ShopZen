import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopzen/core/constants.dart';
import 'package:shopzen/features/product_details/data/mapper/product_mapper.dart';
import 'package:shopzen/features/product_details/data/response/product_response.dart';
import 'package:shopzen/features/product_details/domain/product_model.dart';

class ProductRepository {
  Future get({required String endPoint, Map<String, String>? header}) async {
    return await http.get(Uri.parse(endPoint), headers: header ?? {});
  }

  Future<ProductModel> productDetails({required BuildContext context, required int productId}) async {
    http.Response response = await get(endPoint: ApiRequest.productDetails(productId));
    int statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      var json = jsonDecode(response.body);
      return ProductResponse.fromJson(json).toDomain();
    } else if (statusCode >= 400 && statusCode < 500) {
      var json = jsonDecode(response.body);
      return ProductModel(
        data: [],
        success: json['success'],
        status: json['status'],
      );
    } else if (statusCode >= 500 && statusCode < 600) {
      return ProductModel(data: [], success: false, status: 500);
    }
    return ProductModel(data: [], success: false, status: 404);
  }
}
