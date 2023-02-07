
class BookingRequirementsModel {
  List<dynamic>? sizeRange;
  List<dynamic>? weightRange;

  BookingRequirementsModel({

    this.sizeRange,
    this.weightRange,



  });
  // now create converter

  factory BookingRequirementsModel.fromJson(Map<String,dynamic> responseData){
    return BookingRequirementsModel(
      sizeRange : responseData['sizeRange'] ?? [],
      weightRange: responseData['weightRange'] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "sizeRange": sizeRange,
      "weightRange": weightRange,
    };
  }}