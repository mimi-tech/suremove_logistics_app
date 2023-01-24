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

class BookingServices{
  static dynamic apiUrl = APIConstants.baseUrl;
  static dynamic result = BookingCollections.bookingDetails[0].item;
  static Future<Object> bookingCost(itemNumber, itemSize,distance) async {
    try {
      var body = jsonEncode({
        "itemNumber":itemNumber,
        "itemSize":itemSize,
        "distance":distance
      });
      var url = Uri.parse("$apiUrl/booking/calculate-booking-cost");
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

  static Future<Object> matchADriver(String fullName, String phoneNumber) async {
    try {
      var results;
      results = BookingCollections.bookingDetails[0].item;
      var items = {
        "size":results["itemSize"],
        "number":results["count"],
        "name":results["name"]
      };
      var body = jsonEncode({
      "latitude": BookingCollections.bookingDetails[0].sourceLatitude,
      "longitude": BookingCollections.bookingDetails[0].destinationLatitude,
      "amount": BookingCollections.bookingDetails[0].amount,
      "customerName": fullName,
      "sourceAddress": BookingCollections.bookingDetails[0].sourceAddress,
      "destinationAddress": BookingCollections.bookingDetails[0].destinationAddress,
      "phoneNumber": phoneNumber,
      "item": items,

      });
      var url = Uri.parse("$apiUrl/drivers/match-driver");
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


  static Future<Object> createBookingCollection(Object driverInfo, Object companyDetails, String driverId, String driverAuthId) async {
    try {

      var items = {
        "name":result["itemName"],
        "number":result["itemNumber"],
        "size":result["size"],
      };
      var body = jsonEncode({
        "sourceLatitude":BookingCollections.bookingDetails[0].sourceLatitude,
        "sourceLogitude":BookingCollections.bookingDetails[0].sourceLogitude,
        "destinationLatitude":BookingCollections.bookingDetails[0].destinationLatitude,
        "destinationLogitude":BookingCollections.bookingDetails[0].destinationLogitude,
        "item":items,
        "receiver":BookingCollections.bookingDetails[0].receiver,
        "sender":BookingCollections.bookingDetails[0].sender,
        "driverInfo":driverInfo,
        "amount":BookingCollections.bookingDetails[0].amount,
        "sourceAddress":BookingCollections.bookingDetails[0].sourceAddress,
        "destinationAddress":BookingCollections.bookingDetails[0].destinationAddress,
        "totalAmount":BookingCollections.bookingDetails[0].totalAmount,
        "companyDetails":companyDetails,
        "distance":BookingCollections.bookingDetails[0].distance,
        "timeTaken":BookingCollections.bookingDetails[0].timeTaken,
        "country":BookingCollections.bookingDetails[0].country,
        "state":BookingCollections.bookingDetails[0].state,
        "methodOfPayment":BookingCollections.bookingDetails[0].methodOfPayment,
        "driverId":driverId,
        "driverAuthId":driverAuthId,
      });
      var url = Uri.parse("$apiUrl/booking/booking-account");
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


  static Future<Object> driverConnectionStatus(String driverId) async {
    try {
      var url = Uri.parse("$apiUrl/drivers/match-driver?driverId=$driverId");
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


  static Future<Object> updateBooking( size, number,name,isLegal,bookingId,totalAmount, amount) async {
    try {

      var body = jsonEncode({
        "size":size,
        "number":number,
        "name":name,
        "isLegal":isLegal,
        "bookingId":bookingId,
        "totalAmount":totalAmount,
        "amount":amount
      });
      var url = Uri.parse("$apiUrl/booking/update-booking");
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

  static Future<Object> cancelBooking( message) async {
    try {

      var body = jsonEncode({
        "message":message,
      });
      var url = Uri.parse("$apiUrl/booking/cancel-booking");
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
}