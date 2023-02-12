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
  static dynamic uploadApiUrl = APIConstants.uploadUrl;

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

  static Future<Object> updateProfile({updateEmail,updateUsername,profileImageUrl,firstName,lastName,gender}) async {
    try {

      var body = json.encode({
        "updateEmail":updateEmail,
        "updateUsername":updateUsername,
        "profileImageUrl":profileImageUrl,
        "firstName":firstName,
        "lastName":lastName,
        "gender":gender
      });
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$apiUrl/update-account-data");

      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
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

  static  uploadImage({file}) async {
    try {

      var url = Uri.parse("$uploadApiUrl/upload-files");
      var request = https.MultipartRequest('POST', url);
      request.files.add(await https.MultipartFile.fromPath("file", file));
      var res = await request.send();

        if (res.statusCode == 200) {
          var response = await https.Response.fromStream(res);

          final Map<String, dynamic> jsonDecoded = json.decode(response.body);

          return Success(response: response,data: jsonDecoded);
        }
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: res.reasonPhrase);
      } on HttpException {
        return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
      } on FormatException {
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
      } on SocketException {
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
      } on TimeoutException{
        return Failure(code: TIME_OUT, errorResponse: "Time out error");


    }catch (e) {

      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> deleteImage({fileName}) async {
    try {
      var body = json.encode({
        "fileName":fileName,
      });
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$uploadApiUrl/delete-files");

      Response response = await https.delete(url, headers: {'Content-Type': 'application/json' },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {
        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
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

  static Future<Object> getAllNotification() async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$apiUrl/commons/get-notification?page=1");

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

  static Future<Object> writeToSupport(header,message) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$apiUrl/send-email-verification-code");
      var body = json.encode({
        "header":header,
        "message":message
      });
      Response response = await https.post(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
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

  static Future<Object> accountStatus(type) async {
    try {
      String token = await UserPreferences().getToken();
      String userId = await UserPreferences().getUserId();
      var url = Uri.parse("$apiUrl/users/account-status");
      var body = json.encode({
        "authId":userId,
        "type":type,
      });
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded, message: jsonDecoded["message"]);

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