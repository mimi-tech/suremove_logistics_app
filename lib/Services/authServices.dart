import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Services/apiConstants.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:http/http.dart';

class AuthServices{
   static dynamic apiUrl = APIConstants.baseUrl;
   static dynamic smsApiUrl = APIConstants.smsUrl;
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
        return Success(response: response,data: jsonDecoded, message:jsonDecoded['message'].toString() );
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
     firstName,lastName, gender,referralId,txnPin
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
         'txnPin':txnPin

       });
       var url = Uri.parse("$apiUrl/create-account");

       Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
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

   static Future<Object> sendEmailVerificationCode({emailAddress, newEmailAddress}) async {
     try {
       String token = await UserPreferences().getToken();

       var body = json.encode({
         'emailAddress': emailAddress,
         "newEmailAddress":newEmailAddress.toString()

       });
       var url = Uri.parse("$apiUrl/send-email-code");

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

   static Future<Object> updatePassword(password,email) async {
     try {
       var body = json.encode({
         'password': password,
         "email":email

       });
       var url = Uri.parse("$apiUrl/update-password");

       Response response = await https.put(
           url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded,message: jsonDecoded["message"]);
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

   static Future<Object> updatePhoneNumber(newPhoneNumber) async {
     try {
       String token = await UserPreferences().getToken();
       var body = json.encode({
         'newPhoneNumber': newPhoneNumber,

       });
       var url = Uri.parse("$apiUrl/users/update-phone-number");

       Response response = await https.put(
           url, headers: {'Content-Type': 'application/json','authorization':token}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded,message:jsonDecoded['message'] );
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

   static Future<Object> verifyEmailVerificationCode() async {
     try {
       String token = await UserPreferences().getToken();
       String userId = await UserPreferences().getUserId();
       var body = json.encode({
         "newEmail":email,
         "authId":userId
       });
       var url = Uri.parse("$apiUrl/verify-email-code");

       Response response = await https.post(
           url, headers: {'Content-Type': 'application/json','authorization':token}, body: body);
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


   static Future<Object> sendPhoneNumberCode(phoneNumber) async {
     try {
       var body = json.encode({
         'phoneNumber': phoneNumber,

       });
       var url = Uri.parse("$smsApiUrl/send-sms-verification-code");

       Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded,message: jsonDecoded["message"]);
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


   static Future<Object> sendEmailCode() async {
     try {

       var body = json.encode({
         'user': email,
         'code':123456,
         'template':"verificationCode",
         'name':"Hi",

       });
       var url = Uri.parse("$smsApiUrl/send-email-verification-code");

       Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
       final Map<String, dynamic> jsonDecoded = json.decode(response.body);
       if (jsonDecoded['status'] == true) {
         return Success(response: response, data: jsonDecoded,message: jsonDecoded["message"]);
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