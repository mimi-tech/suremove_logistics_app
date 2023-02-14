
class BookingRequirementsModel {
  List<dynamic>? sizeRange;
  List<dynamic>? weightRange;
  dynamic companyName;
  dynamic companyAddress;

  BookingRequirementsModel({

    this.sizeRange,
    this.weightRange,
    this.companyName,
    this.companyAddress



  });
  // now create converter

  factory BookingRequirementsModel.fromJson(Map<String,dynamic> responseData){
    return BookingRequirementsModel(
      sizeRange : responseData['sizeRange'] ?? [],
      weightRange: responseData['weightRange'] ?? [],
      companyName: responseData['companyName'] ?? "",
      companyAddress: responseData['companyAddress'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "sizeRange": sizeRange,
      "weightRange": weightRange,
      "companyName":companyName,
      "companyAddress":companyAddress
    };
  }}