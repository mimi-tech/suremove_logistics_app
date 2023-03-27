class EarningModel{
  dynamic createdAt;
  Object? item;
  dynamic partnerAmount;
  dynamic ownerAmount;
  dynamic driverAmount;
  dynamic contributorAmount;
  dynamic companyName;
  dynamic ownerId;
  dynamic companyId;
  dynamic contributorId;
  dynamic driverId;
  Object? companyDetails;
  dynamic methodOfPayment;
  dynamic totalAmount;

  EarningModel({
   this.createdAt,
   this.item,
   this.partnerAmount,
   this.ownerAmount,
   this.driverAmount,
   this.contributorAmount,
   this.companyName,
    this.ownerId,
    this.companyId,
    this.contributorId,
    this.driverId,
    this.companyDetails,
    this.methodOfPayment,
    this.totalAmount,
});

  factory EarningModel.fromJson(Map<String, dynamic> responseData){
    return EarningModel(
      createdAt: responseData["createdAt"]??DateTime.now(),
      item: responseData["item"]??{},
      partnerAmount: responseData["partnersAmount"]??0,
      ownerAmount: responseData["ownerAmount"]??0,
      driverAmount: responseData["driversAmount"]??0,
      contributorAmount: responseData["contributorAmount"]??0,
      ownerId: responseData["ownerId"]??"",
      companyId: responseData["companyId"]??"",
      contributorId: responseData["contributorId"]??"",
      driverId: responseData["driverId"]??"",
      companyDetails: responseData["companyDetails"]??{},
      methodOfPayment: responseData["methodOfPayment"]??"",
      totalAmount: responseData["totalAmount"]??0,

    );

  }

 Map<String,dynamic> toJson(){
    return {
      "createdAt": createdAt,
      "item": item,
      "partnerAmount": partnerAmount,
      "ownerAmount": ownerAmount,
      "driverAmount": driverAmount,
      "contributorAmount": contributorAmount,
      "ownerId": ownerId,
      "companyId": companyId,
      "contributorId": contributorId,
      "driverId": driverId,
      "companyDetails":companyDetails,
      "methodOfPayment":methodOfPayment,
      "totalAmount":totalAmount

    };

 }

}