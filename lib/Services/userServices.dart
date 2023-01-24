import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Services/apiConstants.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:http/http.dart';

class UserServices{
  static dynamic apiUrl = APIConstants.baseUrl;

  static Future<Object> getAUser() async {
    try {
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$apiUrl/users/get-a-user?authId=$userId");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {
        return Success(response: response,data: jsonDecoded);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
}