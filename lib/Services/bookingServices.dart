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
      var paymentType = await UserPreferences().getPaymentType();

      var results;
      results = BookingCollections.bookingDetails[0].item;
      var items = {
        "size":results["itemSize"].toString(),
        "number":results["itemCount"],
        "name":results["itemName"].toString()
      };
      var body = jsonEncode({
      "latitude": BookingCollections.bookingDetails[0].sourceLatitude,
      "longitude": BookingCollections.bookingDetails[0].sourceLogitude,
      "amount": BookingCollections.bookingDetails[0].amount,
      "customerName": fullName,
      "sourceAddress": BookingCollections.bookingDetails[0].sourceAddress,
      "destinationAddress": BookingCollections.bookingDetails[0].destinationAddress,
      "phoneNumber": phoneNumber,
      "item": items,
      "paymentMethod":  paymentType.toLowerCase(),

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
      var paymentType = await UserPreferences().getPaymentType();
      var items = {
        "size":result["itemSize"].toString(),
        "number":result["itemCount"],
        "name":result["itemName"].toString(),

      };
      var receiver = {
        "name" : "Prince John",
        "phoneNumber":"+23498454543",
        "address":"Orlu Rd Amakaohia Akwakuma",
        "gender":"Male"
      };
      var body = jsonEncode({
        "sourceLatitude":BookingCollections.bookingDetails[0].sourceLatitude,
        "sourceLogitude":BookingCollections.bookingDetails[0].sourceLogitude,
        "destinationLatitude":BookingCollections.bookingDetails[0].destinationLatitude,
        "destinationLogitude":BookingCollections.bookingDetails[0].destinationLogitude,
        "item":items,
        "receiver":receiver,//BookingCollections.bookingDetails[0].receiver,
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
        "methodOfPayment":paymentType.toString().toLowerCase(),
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

      print("Error in creating booking ${jsonDecoded['message']}");
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
      print("Error in creating booking $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }

  }


  static Future<Object> driverConnectionStatus(String driverId) async {
    try {
      var url = Uri.parse("$apiUrl/drivers/get-driver-booking-connection?driverId=$driverId&type=accept");
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


  static Future<Object> updateBooking( item,isLegal,bookingId,totalAmount, amount) async {
    try {

      var body = jsonEncode({
        "item":item,
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

  static Future<Object> getABooking(customerAuthId) async {
    try {
      var url = Uri.parse("$apiUrl/booking/get-a-booking?customerAuthId=$customerAuthId");
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


  static Future<Object> customerConfirmBooking( bookingId,customerAuth) async {
    try {

      var body = jsonEncode({
        "bookingId":bookingId,
        "customerAuth":customerAuth
      });
      var url = Uri.parse("$apiUrl/booking/customer-confirm-booking");
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



