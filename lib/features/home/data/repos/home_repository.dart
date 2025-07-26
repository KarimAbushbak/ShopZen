import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopzen/core/constants.dart';
import 'package:shopzen/features/home/data/response/home_response.dart';
import 'package:shopzen/features/home/domain/models/home_model.dart';
import 'package:shopzen/features/home/data/mapper/home_mapper.dart';

class HomeRepository {
  Future get({required String endPoint, Map<String, String>? header}) async {
    return await http.get(Uri.parse(endPoint), headers: header ?? {});
  }

  Future<HomeModel> home({required BuildContext context}) async {
    http.Response response = await get(endPoint: ApiRequest.home);
    int statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      var json = jsonDecode(response.body);
      return HomeResponse.fromJson(json).toDomain();
    } else if (statusCode >= 400 && statusCode < 500) {
      var json = jsonDecode(response.body);
      return HomeModel(
        data: [],
        success: json['success'],
        status: json['status'],
      );
    } else if (statusCode >= 500 && statusCode < 600) {
      return HomeModel(data: [], success: false, status: 500);
    }
    return HomeModel(data: [], success: false, status: 404);
  }
}
