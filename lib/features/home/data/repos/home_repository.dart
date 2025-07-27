import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopzen/core/constants.dart';
import 'package:shopzen/features/home/data/response/home_response.dart';
import 'package:shopzen/features/home/data/mapper/home_mapper.dart';
import 'package:shopzen/features/home/domain/models/home_model.dart';

class HomeRepository {
  final http.Client client;

  HomeRepository({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> _get(String url, {Map<String, String>? headers}) async {
    return await client.get(Uri.parse(url), headers: headers ?? {});
  }

  Future<HomeModel> fetchHomeData() async {
    try {
      final response = await _get(ApiRequest.home);

      final statusCode = response.statusCode;
      final body = jsonDecode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        return HomeResponse.fromJson(body).toDomain();
      }

      return HomeModel(
        data: [],
        success: body['success'] ?? false,
        status: body['status'] ?? statusCode,
      );
    } catch (e) {
      return HomeModel(
        data: [],
        success: false,
        status: 500,
      );
    }
  }
}
