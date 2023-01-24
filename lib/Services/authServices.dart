import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:sure_move/Services/apiConstants.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:http/http.dart';

class AuthServices{
   static dynamic apiUrl = APIConstants.baseUrl;
  static Future<Object> loginUser(emailAddress, password) async {
    try {

      var body = json.encode({
        'email': emailAddress,
        'password': password
      });
      var url = Uri.parse("$apiUrl/login");

      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
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


   static Future<Object> registerUser({
     emailAddress,password,phoneNumber,username,profileImageUrl,
     firstName,lastName, gender,referralId,whoAreYou,txnPin
   }) async {
     try {

       var body = json.encode({
         'email': emailAddress,
         'password': password,
         'phoneNumber':phoneNumber,
         'username':username,
         'profileImageUrl':profileImageUrl,
         'firstName':firstName,
         'lastName':lastName,
         'gender':gender,
         'referralId':referralId,
         'whoAreYou':whoAreYou,
         'txnPin':txnPin

       });
       var url = Uri.parse("$apiUrl/create-account");

       Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
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

   static Future<Object> sendEmailVerificationCode(emailAddress) async {
     try {
       var body = json.encode({
         'email': emailAddress,

       });
       var url = Uri.parse("$apiUrl/forgotPassword");

       Response response = await https.post(
           url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded);
       }
       return Failure(
           code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
     } on HttpException {
       return Failure(
           code: NO_INTERNET, errorResponse: "Internal server error");
     } on FormatException {
       return Failure(
           code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
     } on SocketException {
       return Failure(code: USER_INVALID_RESPONSE,
           errorResponse: "No internet connection");
     } on TimeoutException {
       return Failure(code: TIME_OUT, errorResponse: "Time out error");
     }

     catch (e) {
       return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
     }
   }

   static Future<Object> updatePassword(password) async {
     try {
       var body = json.encode({
         'password': password,

       });
       var url = Uri.parse("$apiUrl/update-password");

       Response response = await https.post(
           url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded);
       }
       return Failure(
           code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
     } on HttpException {
       return Failure(
           code: NO_INTERNET, errorResponse: "Internal server error");
     } on FormatException {
       return Failure(
           code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
     } on SocketException {
       return Failure(code: USER_INVALID_RESPONSE,
           errorResponse: "No internet connection");
     } on TimeoutException {
       return Failure(code: TIME_OUT, errorResponse: "Time out error");
     }

     catch (e) {
       return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
     }
   }
}