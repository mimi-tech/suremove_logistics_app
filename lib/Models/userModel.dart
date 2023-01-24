
class NewUser {
  String? email;
  String? password;
  String? userId;
  bool? isEmailVerified;
  String? phoneNumber;
  String? username;
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  String? gender;
  dynamic walletBalance;
  dynamic referralCount;
  String? accountType;
  dynamic txnPin;
  bool? isOngoingBooking;
  bool? isActive;

  NewUser({

    this.email,
    this.password,
    this.userId,
    this.isEmailVerified,
    this.phoneNumber,
    this.username,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.walletBalance,
    this.referralCount,
    this.accountType,
    this.txnPin,
    this.isOngoingBooking,
    this.isActive,



  });
  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      email : responseData['email'] ?? "",
      password: responseData['password'] ?? "",
      userId: responseData['id'] ?? "",
      isEmailVerified: responseData['isEmailVerified'] ?? false,
      phoneNumber: responseData['phoneNumber'] ?? "",
      username: responseData['username'] ?? "",
      profileImageUrl: responseData['profileImageUrl'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      gender: responseData['gender'] ?? "",
      walletBalance: responseData['walletBalance'] ?? "",
      referralCount: responseData['referralCount'] ?? "",
      accountType: responseData['whoAreYou'] ?? "",
      txnPin: responseData['txnPin'] ?? "",
      isOngoingBooking: responseData['isOngoingBooking'] ?? false,
      isActive: responseData['inActive'] ?? true,

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "password": password,
      "userId":userId,
      "isEmailVerified":isEmailVerified,
      "phoneNumber":phoneNumber,
      "username":username,
      "profileImageUrl":profileImageUrl,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "walletBalance":walletBalance,
      "referralCount":referralCount,
      "accountType":accountType,
      "txnPin":txnPin,
      "isOngoingBooking":isOngoingBooking,

    };
  }}