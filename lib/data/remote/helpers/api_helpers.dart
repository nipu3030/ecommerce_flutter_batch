import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/data/remote/helpers/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/constants/app_constants.dart';
class ApiHelpers {
  Future<dynamic> getApi({required String url}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(AppConstants.PREF_TOKEN_KEY) ?? "";
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    try {
      var res = await http.get(Uri.parse(url),headers: headers);
      return returnResponse(res);
    } on SocketException catch (e) {
      throw NoInternetException(message: e.toString());
    } catch (e) {
      throw FetchDataException(message: e.toString());
    }
  }

  Future<dynamic> postApi({required String url, Map<String, dynamic>? mBodyParams, Map<String, String>? mHeaders, bool isAuth = false}) async {

    if(!isAuth){
      mHeaders ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.PREF_TOKEN_KEY) ?? "";
      mHeaders["Authorization"] = "Bearer $token";

    }

    try{
      var res = await http.post(
          Uri.parse(url),
          body: mBodyParams != null ? jsonEncode(mBodyParams) : null,
        headers: mHeaders,

      );
      return returnResponse(res);

    } on SocketException catch (e){
      throw NoInternetException(message: e.toString());
    } catch (e){
      throw FetchDataException(message: e.toString());
    }
  }
}

dynamic returnResponse(http.Response response) {
  dynamic data;
  try {
    data = jsonDecode(response.body);
  } catch (e) {
    // If not JSON, but status is 200, it might be an empty or non-JSON success
    if (response.statusCode == 200) return response.body;
    throw FetchDataException(message: "Invalid response from server");
  }

  switch (response.statusCode) {
    case 200:
      return data;
    case 401:
    case 403:
      throw UnauthorisedException(message: data['message'] ?? "Unauthorized");
    case 400:
      throw BadRequestException(message: data['message'] ?? "Bad Request");
    case 500:
    case 502:
    default:
      throw ServerException(
          message: data['message'] ??
              "Server error with status code: ${response.statusCode}");
  }
}