import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopzen/core/storage/local/datatbase/app_settings_shared_preferences.dart';
import 'package:shopzen/features/auth/data/mapper/login_mapper.dart';

import '../../../../core/constants.dart';
import '../../../../core/widgets/helpers.dart';
import '../../domain/models/login_model.dart';
import '../response/login_response.dart';

class AuthRepository with Helpers {
   AppSettingsSharedPreferences appSettingsSharedPreferences =
      AppSettingsSharedPreferences();

  Future post ({
    required String endPoint,
    required Map<String, dynamic> body,
    required Map<String, String> header,


  })async{
    return await http.post(
      Uri.parse(endPoint),
      body: body,
      headers: header,
    );
  }
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await post(
        endPoint: ApiRequest.login,
        body: {ApiConstants.email: email, ApiConstants.password: password},
        header: {
          ApiConstants.acceptLanguage: appSettingsSharedPreferences.defaultLocale,
        },
      );
      var json = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        LoginResponse loginResponse = LoginResponse.fromJson(json);
        LoginModel loginModel = loginResponse.toDomain();
        appSettingsSharedPreferences.setToken(loginModel.accessToken);
        appSettingsSharedPreferences.saveUserInfo(loginModel.user);
        appSettingsSharedPreferences.setLoggedIn();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }


   Future<bool> register({
     required String email,
     required String password,
     required String confirmPassword,
     required String name,
     required String phone,
   }) async {
     try {
       http.Response response = await post(
         endPoint: ApiRequest.register,
         body: {
           ApiConstants.email: email,
           ApiConstants.password: password,
           ApiConstants.confirmPassword: confirmPassword,
           ApiConstants.authName: name,
           ApiConstants.phone: phone,
           ApiConstants.registerBy: 'email',
         },
         header: {},
       );
       if (response.statusCode >= 200 && response.statusCode < 300) {
         return true;
       }
       return false;
     } catch (e) {
       return false;
     }
   }




}