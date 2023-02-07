
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';
import 'package:sure_move/Services/apiConstants.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:sure_move/Services/apiStatus.dart';
class FundsServices{
  static dynamic apiUrl = APIConstants.payStack;
  static dynamic sureMoveApiUrl = APIConstants.baseUrl;

  //create customer
  static Future<Object> createCustomer(String phoneNumber,String email,String firstname, String lastname) async {
  try {
    print("hhhh$email");
  var body = json.encode({
  'email': email,
  'first_name': firstname,
  'last_name':lastname,
  'phone':phoneNumber,
  });
  var url = Uri.parse("$apiUrl/customer");
  Response response = await https.post(url, headers: {'Content-Type': 'application/json','Authorization': "Bearer $testSecretKey"},body: body);
  if (response.statusCode == 200) {
  final Map<String, dynamic> responseData = json.decode(response.body);

  return Success(response: response, data: responseData);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
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
    print("22222 $e");
    return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
  }
  }


  static Future<Object> verifyCardBin(lastDigit) async {
  try {

  var url = Uri.parse("$apiUrl/decision/bin/$lastDigit");
  Response response = await https.get(url, headers: {'Authorization': "Bearer $testSecretKey"});
  if (response.statusCode == 200) {
  final Map<String, dynamic> responseData = json.decode(response.body);
  return Success(response: response, data: responseData);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
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


  static Future<Object> initializePayment(email, amount) async {
  try {
  //First initialize payment

  var body = json.encode({
  'email': email,
  'amount': amount,
  });
  var url = Uri.parse("$apiUrl/transaction/initialize");
  Response response = await https.post(url, headers: {'Authorization': "Bearer $testSecretKey"}, body: body);

  if (response.statusCode == 200) {
  final Map<String, dynamic> jsonDecoded = json.decode(response.body);

  return Success(response: response, data: jsonDecoded);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
  } on HttpException {
    return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
  } on FormatException {
    print("its here2");
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


  static Future<Object>  verifySuccessTxn(reference) async {
  try {
  var url = Uri.parse("$apiUrl/transaction/verify/$reference");
  Response response = await https.get(url, headers: {"Authorization": 'Bearer $testSecretKey'});
  if (response.statusCode == 200) {
  final Map<String,dynamic> jsonDecoded = json.decode(response.body);
  var cardData = jsonDecoded['data']['authorization'];

  return Success(response: response, data: jsonDecoded);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
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


  static Future<Object> chargeAuthorization(String email, dynamic amount, dynamic authorizationCode) async {

  try {

  var body = json.encode({
  'email': email,
  'amount': amount,
  'authorization_code':authorizationCode
  });
  var url = Uri.parse("$apiUrl/transaction/charge_authorization");
  Response response = await https.post(url, headers: {'Authorization': "Bearer $testSecretKey"}, body: body);

  if (response.statusCode == 200) {
  final Map<String,dynamic> jsonDecoded = json.decode(response.body);
  return Success(response: response, data: jsonDecoded);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
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



  //fetching users transactions

  static Future<Object> customerTransactions() async {

  try {
  //get customer id

  int customerId = await UserPreferences().getCustomerId();
  var url = Uri.parse("$apiUrl/transaction/$customerId");
  Response response = await https.get(url, headers: {'Authorization': "Bearer $testSecretKey"});
  if (response.statusCode == 200) {
  final Map<String,dynamic> jsonDecoded = json.decode(response.body);

  return Success(response: response, data: jsonDecoded);

  }
  return Failure(code: USER_INVALID_RESPONSE, errorResponse: response.body);
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

  static Future<Object> updateWallet(amount,userAuthId,type,userEmail) async {
    var body = jsonEncode({
      "amount":amount,
      "userAuthId":userAuthId,
      "type":type,
      "userEmail":userEmail
    });
    try {
      var url = Uri.parse("$sureMoveApiUrl/users/update-wallet");
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

}