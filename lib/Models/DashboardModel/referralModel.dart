
class ReferralModel {
  String? email;
  String? profileImageUrl;
  String? firstName;
  String? lastName;
  dynamic date;

  ReferralModel({

    this.email,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.date,


  });
  // now create converter

  factory ReferralModel.fromJson(Map<String,dynamic> responseData){
    return ReferralModel(
      email : responseData['email'] ?? "",
      profileImageUrl: responseData['profileImageUrl'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      date: responseData['date'] ?? "",


    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "profileImageUrl":profileImageUrl,
      "firstName":firstName,
      "lastName":lastName,
      "date":date,

    };
  }}