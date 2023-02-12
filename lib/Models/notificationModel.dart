
class NotificationModel {
  String? id;
  String? message;
  List? accountType;
  Object? postedBy;
  dynamic year;
  dynamic month;
  dynamic week;
  dynamic monthName;
  dynamic day;
  bool? read;
  dynamic timestamp;

  NotificationModel({

    this.id,
    this.message,
    this.accountType,
    this.postedBy,
    this.year,
    this.month,
    this.week,
    this.monthName,
    this.day,
    this.read,
    this.timestamp,
  });
  // now create converter

  factory NotificationModel.fromJson(Map<dynamic,dynamic> responseData){
    return NotificationModel(
      id : responseData['_id'] ?? "",
      message: responseData['message'] ?? "",
      accountType: responseData['accountType'] ?? [],
      postedBy: responseData['postedBy'] ?? {},
      year: responseData['year'] ?? 0000,
      month: responseData['month'] ?? 00,
      week: responseData['week'] ?? 0,
      monthName: responseData['monthName'] ?? "",
      day: responseData['day'] ?? 0,
      read: responseData['read'] ?? false,
      timestamp: responseData['timestamp'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "id": id,
      "message": message,
      "accountType":accountType,
      "postedBy":postedBy,
      "year":year,
      "month":month,
      "week":week,
      "monthName":monthName,
      "day":day,
      "read":read,
      "timestamp":timestamp,
    };
  }}