class HistoryModel{
  String? transactionId;
  String? transaction;
  dynamic amount;
  String? sign;
  dynamic dateAdded;

  HistoryModel({
   this.transactionId,
   this.transaction,
   this.amount,
   this.sign,
   this.dateAdded
});

  factory HistoryModel.fromJson(Map<String,dynamic> responseData){
    return HistoryModel(
      transactionId: responseData["_id"]??"",
      transaction:  responseData["transaction"]??"",
      amount: responseData["amount"]??0,
      sign: responseData["sign"]??"",
      dateAdded: responseData["date"]??""
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "transactionId" : transactionId,
      "transaction":transaction,
      "amount": amount,
      "sign":sign,
      "dateAdded":dateAdded
    };
  }

}