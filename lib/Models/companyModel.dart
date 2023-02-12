
class CompanyModel {
  String? companyId;
  String? companyName;
  int? bykeCount;
  int? driversCount;
  bool? owner;
  String? ownerId;
  String? email;
  bool? suspended;
  String? address;


  CompanyModel({
    this.companyId,
    this.companyName,
    this.bykeCount,
    this.driversCount,
    this.owner,
    this.ownerId,
    this.email,
    this.suspended,
    this.address,
  });
  // now create converter

  factory CompanyModel.fromJson(Map<String,dynamic> responseData){
    return CompanyModel(
      companyId : responseData['_id'] ?? "",
      companyName : responseData['companyName'] ?? "",
      bykeCount: responseData['bykeCount'] ?? 0,
      driversCount: responseData['driversCount'] ?? 0,
      owner: responseData['owner'] ?? false,
      ownerId: responseData['ownerId'] ?? "",
      email: responseData['email'] ?? "",
      suspended: responseData['suspended'] ?? false,
      address: responseData['address'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "companyId":companyId,
      "companyName": companyName,
      "bykeCount": bykeCount,
      "driversCount":driversCount,
      "owner":owner,
      "ownerId":ownerId,
      "email":email,
      "suspended":suspended,
      "address":address,

    };
  }}