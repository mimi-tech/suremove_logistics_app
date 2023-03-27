import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Services/apiConstants.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:sure_move/Services/apiStatus.dart';
import 'package:http/http.dart';

class DriverServices{
  static dynamic apiUrl = APIConstants.baseUrl;
  static Future<Object> getADriver(driverId) async {
    try {
      var url = Uri.parse("$apiUrl/drivers/get-a-driver?driverAuthId=$driverId");
      String token = await UserPreferences().getToken();
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

  static Future<Object> updateDriverStatus(driverId,type) async {
    var body = jsonEncode({
      "driverId":driverId,
      "type":type
    });
    try {
      var url = Uri.parse("$apiUrl/drivers/driver-status");
      String token = await UserPreferences().getToken();
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
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

  static Future<Object> updateDriverLocation(driverId,latitude,logitude,currentLocationAddress) async {
    var body = jsonEncode({
      "driverId":driverId,
      "latitude":5.5134,//latitude,
      "logitude":7.1629,//logitude,
      "currentLocationAddress":currentLocationAddress
    });
    try {
      var url = Uri.parse("$apiUrl/drivers/update-current-location");
      String token = await UserPreferences().getToken();
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      //print(response.body);
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


  static Future<Object> getADriverBookingConnection(driverId) async {
          try {
          var url = Uri.parse("$apiUrl/drivers/get-driver-booking-connection?driverId=$driverId&type=connection");
          String token = await UserPreferences().getToken();
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

  static Future<Object> getADriverBookingDecision(driverId,customerId,type) async {

    var body = jsonEncode({
      "driverId":driverId,
      "customerId":customerId,
      "type":type
    });
    try {
      var url = Uri.parse("$apiUrl/drivers/driver-booking-decision");
      String token = await UserPreferences().getToken();
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body:body);
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

  static Future<Object> driverConfirmBooking(driverId,companyId,bookingAmount,distance) async {

    var body = jsonEncode({
      "driverId":driverId,
      "companyId":companyId,
      "bookingAmount":bookingAmount,
      "distance":distance,
    });
    try {
      var url = Uri.parse("$apiUrl/booking/driver-confirm-booking");
      String token = await UserPreferences().getToken();
      Response response = await https.post(url, headers: {'Content-Type': 'application/json','authorization':token },body:body);
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

  static Future<Object>registerDriver(
      companyId,
      homeAddress,
      currentLocation,
      currentLocationLat,
      currentLocationLog,
      lincense,
      owner,
      country,
      state,
      driverEmail
      ) async {
    try {

      var body = jsonEncode({
        "companyId":companyId,
        "homeAddress":homeAddress,
        "currentLocation":currentLocation,
        "currentLocationLat":currentLocationLat,
        "currentLocationLog":-122.406417,//currentLocationLog,
        "lincense":lincense,
        "owner":owner,
        "country":country,
        "state":state,
        "driverEmail":driverEmail,
      });
      var url = Uri.parse("$apiUrl/drivers/create-driver-account");
      String token = await UserPreferences().getToken();
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
  static Future<Object> driverBookingRejections( driverId,firstName,lastName,email,companyId,customerInfo,phoneNumber,profilePicture,amount,companyInfo,bookingDetails) async {
    try {

      var body = jsonEncode({
        "driverId":driverId,
        "firstName":firstName,
        "lastName":lastName,
        "email":email,
        "companyId":companyId,
        "customerInfo":customerInfo,
        "phoneNumber":phoneNumber,
        "profilePicture":profilePicture,
        "companyInfo":companyInfo,
        "bookingDetails":bookingDetails

      });
      var url = Uri.parse("$apiUrl/drivers/create-rejected-booking");
      String token = await UserPreferences().getToken();
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

  static Future<Object> ratingDriver( message,companyID,rate,customerInfo,driverInfo,driverId) async {
    try {

      var body = jsonEncode({
        "message":message,
        "companyID":companyID,
        "rate":rate,
        "customerInfo":customerInfo,
        "driverInfo":driverInfo,
        "driverId":driverId
      });
      var url = Uri.parse("$apiUrl/drivers/rate-a-driver");
      String token = await UserPreferences().getToken();
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
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