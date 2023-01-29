
class BookingModel {
  dynamic bookingId;
  String? customerAuthId;
  String? driverAuthId;
  String? driverId;
  dynamic sourceLatitude;
  dynamic sourceLogitude;
  dynamic destinationLatitude;
  dynamic destinationLogitude;
  Object? item;
  Object? receiver;
  Object? sender;
  Object? driverInfo;
  String? accountType;
  bool? delivered;
  bool? confirmDelivery;
  dynamic amount;
  bool? isPaymentSuccessful;
  bool? ongoing;
  String? sourceAddress;
  String? destinationAddress;
  int? year;
  int? month;
  String? monthName;
  int? week;
  int? day;
  dynamic totalAmount;
  Object? companyDetails;
  dynamic distance;
  dynamic timeTaken;
  dynamic country;
  dynamic state;
  dynamic methodOfPayment;
  bool? cancelBooking;
  bool? isLegal;


  BookingModel({
    this.bookingId,
    this.customerAuthId,
   this.driverAuthId,
  this.driverId,
  this.sourceLatitude,
  this.sourceLogitude,
    this.destinationLatitude,
    this.destinationLogitude,
    this.item,
    this.receiver,
    this.sender,
    this.driverInfo,
    this.accountType,
    this.delivered,
    this.confirmDelivery,
    this.amount,
    this.isPaymentSuccessful,
    this.ongoing,
    this.sourceAddress,
    this.destinationAddress,
    this.year,
    this.month,
    this.monthName,
    this.week,
    this.day,
    this.totalAmount,
    this.companyDetails,
    this.distance,
    this.timeTaken,
    this.country,
    this.state,
    this.methodOfPayment,
    this.cancelBooking,
    this.isLegal

  });
  // now create converter

  factory BookingModel.fromJson(Map<String,dynamic> responseData){
    return BookingModel(
      bookingId : responseData['_id'] ?? "",
      customerAuthId : responseData['customerAuthId'] ?? "",
      driverAuthId: responseData['driverAuthId'] ?? "",
      driverId: responseData['driverId'] ?? "",
      sourceLatitude: responseData['sourceLatitude'] ?? false,
      sourceLogitude: responseData['sourceLogitude'] ?? "",
      destinationLatitude: responseData['destinationLatitude'] ?? "",
      destinationLogitude: responseData['destinationLogitude'] ?? "",
      item: responseData['item'] ?? {},
      receiver: responseData['receiver'] ?? {},
      sender: responseData['sender'] ?? {},
      driverInfo: responseData['driverInfo'] ?? {},
      delivered: responseData['delivered'] ?? false,
      accountType: responseData['whoAreYou'] ?? "",
      confirmDelivery: responseData['confirmDelivery'] ?? true,
      amount: responseData['amount'] ?? 0,
      isPaymentSuccessful: responseData['isPaymentSuccessful'] ?? false,
      ongoing: responseData['ongoing'] ?? true,
      sourceAddress: responseData['sourceAddress'] ?? "",
      destinationAddress: responseData['destinationAddress'] ?? "",
      year: responseData['year'] ?? 0000,
      month: responseData['month'] ?? 00,
      monthName: responseData['monthName'] ?? "",
      week: responseData['week'] ?? 00,
      day: responseData['day'] ?? 00,
      totalAmount: responseData['totalAmount'] ?? 0,
      companyDetails: responseData['companyDetails'] ?? {},
      distance: responseData['distance'] ?? "",
      timeTaken: responseData['timeTaken'] ?? "",
      country: responseData['country'] ?? "",
      state: responseData['state'] ?? "",
      methodOfPayment: responseData['methodOfPayment'] ?? "",
      cancelBooking: responseData['cancelBooking'] ?? "",
      isLegal: responseData['isLegal'] ?? false,

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "bookingId":bookingId,
      "customerAuthId": customerAuthId,
      "driverAuthId": driverAuthId,
      "driverId":driverId,
      "sourceLatitude":sourceLatitude,
      "sourceLogitude":sourceLogitude,
      "destinationLatitude":destinationLatitude,
      "destinationLogitude":destinationLogitude,
      "item":item,
      "receiver":receiver,
      "sender":sender,
      "driverInfo":driverInfo,
      "delivered":delivered,
      "accountType":accountType,
      "confirmDelivery":confirmDelivery,
      "amount":amount,
      "isPaymentSuccessful":isPaymentSuccessful,
      "ongoing":ongoing,
      "sourceAddress":sourceAddress,
      "destinationAddress":destinationAddress,
      "year":year,
      "month":month,
      "monthName":monthName,
      "week":week,
      "day":day,
      "totalAmount":totalAmount,
      "companyDetails":companyDetails,
      "distance":distance,
      "timeTaken":timeTaken,
      "country":country,
      "state":state,
      "methodOfPayment":methodOfPayment,
      "cancelBooking":cancelBooking,
      "isLegal":isLegal

    };
  }}



class CustomerBookingDetailsModel {
  String? userId;
  dynamic sourceLatitude;
  dynamic sourceLogitude;
  dynamic destinationLatitude;
  dynamic destinationLogitude;
  Object? item;
  Object? receiver;
  Object? sender;
  Object? driverInfo;
  dynamic amount;
  bool? isPaymentSuccessful;
  String? sourceAddress;
  String? destinationAddress;
  dynamic totalAmount;
  Object? companyDetails;
  dynamic distance;
  dynamic timeTaken;
  dynamic country;
  dynamic state;
  dynamic methodOfPayment;



  CustomerBookingDetailsModel({
    this.userId,
    this.sourceLatitude,
    this.sourceLogitude,
    this.destinationLatitude,
    this.destinationLogitude,
    this.item,
    this.receiver,
    this.sender,
    this.driverInfo,
    this.amount,
    this.isPaymentSuccessful,
    this.sourceAddress,
    this.destinationAddress,
    this.totalAmount,
    this.companyDetails,
    this.distance,
    this.timeTaken,
    this.country,
    this.state,
    this.methodOfPayment,





  });
  // now create converter

  factory CustomerBookingDetailsModel.fromJson(Map<String,dynamic> responseData){
    return CustomerBookingDetailsModel(
      userId: responseData['userId'] ?? "",
      sourceLatitude: responseData['sourceLatitude'] ?? "",
      sourceLogitude: responseData['sourceLogitude'] ?? "",
      destinationLatitude: responseData['destinationLatitude'] ?? "",
      destinationLogitude: responseData['destinationLogitude'] ?? "",
      item: responseData['item'] ?? {},
      receiver: responseData['receiver'] ?? {},
      sender: responseData['sender'] ?? {},
      driverInfo: responseData['driverInfo'] ?? {},
      amount: responseData['amount'] ?? 0,
      isPaymentSuccessful: responseData['isPaymentSuccessful'] ?? false,
      sourceAddress: responseData['sourceAddress'] ?? "",
      destinationAddress: responseData['destinationAddress'] ?? "",
      totalAmount: responseData['totalAmount'] ?? 0,
      companyDetails: responseData['companyDetails'] ?? {},
      distance: responseData['distance'] ?? "",
      timeTaken: responseData['timeTaken'] ?? "",
      country: responseData['country'] ?? "",
      state: responseData['state'] ?? "",
      methodOfPayment: responseData['methodOfPayment'] ?? "",

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "userId":userId,
      "sourceLatitude":sourceLatitude,
      "sourceLogitude":sourceLogitude,
      "destinationLatitude":destinationLatitude,
      "destinationLogitude":destinationLogitude,
      "item":item,
      "receiver":receiver,
      "sender":sender,
      "driverInfo":driverInfo,
      "amount":amount,
      "isPaymentSuccessful":isPaymentSuccessful,
      "sourceAddress":sourceAddress,
      "destinationAddress":destinationAddress,
      "totalAmount":totalAmount,
      "companyDetails":companyDetails,
      "distance":distance,
      "timeTaken":timeTaken,
      "country":country,
      "state":state,
      "methodOfPayment":methodOfPayment,

    };
  }}