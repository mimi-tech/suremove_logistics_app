import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/DashboardModel/totalEarningModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Services/apiConstants.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:http/http.dart';

class DashboardServices{
  static dynamic apiUrl = APIConstants.baseUrl;

  static Future<Object> getAUserReferrals() async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$apiUrl/users/get-user-referral?page=1");

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


  static Future<Object> allEarnings(  NewUser user ,String driverId) async{
    try{
    var userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var url  = user.accountType  ==  AccountType.driver.name?
    "$apiUrl/analysis/get-user-booking?page=1&driverId=$driverId":
    user.accountType  ==  AccountType.customer.name?
    "$apiUrl/analysis/get-user-booking?page=1&customerId=$userId":
    "$apiUrl/analysis/get-user-booking?page=1&companyId=$userId";
    Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

    final Map<String,dynamic> jsonDecoded = json.decode(response.body);
    if(jsonDecoded["status"] == true){
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



  static Future<Object> allDailyEarnings(  NewUser user ,String driverId) async{
    try{
    var userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var url  = user.accountType  ==  AccountType.driver.name?
    "$apiUrl/analysis/get-daily-analysis?page=1&driverId=$driverId":
    "$apiUrl/analysis/get-daily-analysis?page=1&companyId=$userId";
    Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

    final Map<String,dynamic> jsonDecoded = json.decode(response.body);
    if(jsonDecoded["status"] == true){
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

  static Future<Object> allWeeklyEarnings(  NewUser user ,String driverId) async{
   try{
    var userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var url  = user.accountType  ==  AccountType.driver.name?
    "$apiUrl/analysis/get-current-week-analysis?page=1&driverId=$driverId":
    "$apiUrl/analysis/get-current-week-analysis?page=1&companyId=$userId";
    Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

    final Map<String,dynamic> jsonDecoded = json.decode(response.body);
    if(jsonDecoded["status"] == true){
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

  static Future<Object> allMonthlyEarnings(  NewUser user ,String driverId) async{
    try{
    var userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var url  = user.accountType  ==  AccountType.driver.name?
    "$apiUrl/analysis/get-current-month-analysis?page=1&driverId=$driverId":
    "$apiUrl/analysis/get-current-month-analysis?page=1&companyId=$userId";
    Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

    final Map<String,dynamic> jsonDecoded = json.decode(response.body);
    if(jsonDecoded["status"] == true){
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
  static Future<Object> allYearlyEarnings(  NewUser user ,String driverId) async{
    try{
    var userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var url  = user.accountType  ==  AccountType.driver.name?
    "$apiUrl/analysis/get-current-year-analysis?page=1&driverId=$driverId":
    "$apiUrl/analysis/get-current-year-analysis?page=1&companyId=$userId";
    Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

    final Map<String,dynamic> jsonDecoded = json.decode(response.body);
    if(jsonDecoded["status"] == true){
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

  static Future<Object> history(String type) async{
    try{
      String token = await UserPreferences().getToken();
      var url  = type  ==  ""?
      "$apiUrl/users/get-transaction-history?page=1":
      "$apiUrl/users/get-transaction-history?page=1&type=$type";
      Response response = await https.get(Uri.parse(url),headers: {'Content-Type': 'application/json','authorization':token });

      final Map<String,dynamic> jsonDecoded = json.decode(response.body);
      if(jsonDecoded["status"] == true){
        return Success(response: response,data: jsonDecoded);

      }
      print(jsonDecoded['message']);
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
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }

  }
}