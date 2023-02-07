class Success{
  int? code;
  Object? response;
  String? message;
  Map<String, dynamic>? data;
  Success({this.code, this.response, this.data,this.message});
}

class Success2{
  int? code;
  Map<String, dynamic>? response;
  Success2({this.code, this.response});
}

class Failure{
  int? code;
  String? errorResponse;
  Failure({this.code, this.errorResponse});

}

const USER_INVALID_RESPONSE = 101;
const NO_INTERNET = 102;
const INVALID_FORMAT = 103;
const UNKNOWN_ERROR = 104;
const TIME_OUT = 104;

const dynamic serverError = "Internal server error";
const dynamic internet = "No internet connection";
const dynamic invalidFormat = "Invalid format";
const dynamic timeoutError = "Time out error";

