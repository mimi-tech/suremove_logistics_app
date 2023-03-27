
class DriverModel {
  dynamic driverId;
  dynamic companyId;
  dynamic driverEmail;
  dynamic driverAuthId;
  dynamic driverPhoneNumber;
  dynamic driverUsername;
  dynamic profileImageUrl;
  dynamic firstName;
  dynamic lastName;
  dynamic gender;
  dynamic walletBalance;
  dynamic homeAddress;
  dynamic currentLocation;
  dynamic currentLocationLat;
  dynamic currentLocationLog;
  dynamic loc;
  Object? lincense;
  bool? owner;
  bool? suspended;
  bool? approved;
  bool? onlineStatus;
  bool? onTransit;
  dynamic companyName;
  dynamic rating;
  dynamic country;
  dynamic state;
  dynamic yearlyCount;
  dynamic monthlyCount;
  dynamic weeklyCount;
  dynamic dailyCount;
  dynamic dailyAmount;
  dynamic dateAdded;
  bool? isActive;
  dynamic day;
  dynamic week;
  dynamic month;
  dynamic year;
  dynamic timeCovered;




  DriverModel({
    this.driverId,
    this.companyId,
    this.driverEmail,
    this.driverAuthId,
    this.driverPhoneNumber,
    this.driverUsername,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.walletBalance,
    this.homeAddress,
    this.currentLocation,
    this.currentLocationLat,
    this.currentLocationLog,
    this.loc,
    this.lincense,
    this.owner,
    this.suspended,
    this.approved,
    this.onlineStatus,
    this.onTransit,
    this.companyName,
    this.rating,
    this.country,
    this.state,
    this.yearlyCount,
    this.monthlyCount,
    this.weeklyCount,
    this.dailyCount,
    this.dailyAmount,
    this.dateAdded,
    this.isActive,
    this.day,
    this.week,
    this.month,
    this.year,
    this.timeCovered
  });
  // now create converter

  factory DriverModel.fromJson(Map<String,dynamic> responseData){
    return DriverModel(
      driverId : responseData['_id'] ?? "",
      companyId : responseData['companyId'] ?? "",
      driverEmail: responseData['driverEmail'] ?? "",
      driverAuthId: responseData['driverAuthId'] ?? "",
      driverPhoneNumber: responseData['driverPhoneNumber'] ?? "",
      driverUsername: responseData['driverUsername'] ?? "",
      homeAddress: responseData['homeAddress'] ?? "",
      profileImageUrl: responseData['profileImageUrl'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      gender: responseData['gender'] ?? "",
      walletBalance: responseData['walletBalance'] ?? "",
      currentLocation: responseData['currentLocation'] ?? "",
      currentLocationLat: responseData['currentLocationLat'] ?? "",
      currentLocationLog: responseData['currentLocationLog'] ?? "",
      loc: responseData['loc'] ?? {},
      lincense: responseData['lincense'] ?? {},
      owner: responseData['owner'] ?? true,
      suspended: responseData['suspended'] ?? false,
      approved: responseData['approved'] ?? false,
      onlineStatus: responseData['onlineStatus'] ?? false,
      isActive: responseData['isActive'] ?? true,
      companyName: responseData['companyName'] ?? "",
      rating: responseData['rating'] ?? 1.0,
      country: responseData['country'] ?? "",
      state: responseData['state'] ?? "",
      yearlyCount: responseData['yearlyCount'] ?? 0,
      monthlyCount: responseData['monthlyCount'] ?? 0,
      weeklyCount: responseData['weeklyCount'] ?? 0,
      dailyCount: responseData['dailyCount'] ?? 0,
      dailyAmount: responseData['dailyAmount'] ?? 0,
      dateAdded: responseData['dateAdded'] ?? "",
      day: responseData['day'] ?? DateTime.now().day,
      week: responseData['week'] ?? 0,
      month: responseData['month'] ?? DateTime.now().month,
      year: responseData['year'] ?? DateTime.now().year,
      timeCovered: responseData['timeCovered'] ?? "0",

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "driverId": driverId,
      "companyId": companyId,
      "driverEmail": driverEmail,
      "driverAuthId":driverAuthId,
      "driverPhoneNumber":driverPhoneNumber,
      "homeAddress":homeAddress,
      "driverUsername":driverUsername,
      "profileImageUrl":profileImageUrl,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "walletBalance":walletBalance,
      "currentLocation":currentLocation,
      "currentLocationLat":currentLocationLat,
      "currentLocationLog":currentLocationLog,
      "loc":loc,
      "lincense":lincense,
      "owner":owner,
      "suspended":suspended,
      "approved":approved,
      "onlineStatus":onlineStatus,
      "companyName":companyName,
      "rating":rating,
      "country":country,
      "state":state,
      "yearlyCount":yearlyCount,
      "monthlyCount":monthlyCount,
      "weeklyCount":weeklyCount,
      "dailyCount":dailyCount,
      "dailyAmount":dailyAmount,
      "dateAdded":dateAdded,
      "isActive":isActive,
      "day":day,
      "week":week,
      "month":month,
      "year":year,
      "timeCovered":timeCovered

    };
  }}