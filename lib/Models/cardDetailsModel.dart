class CardDetailsModal {
  String? cardFirstFourDigit;
  String? cardLastFourDigit;
  String? authorizationCode;
  String? cardType;
  String? cardBrand;
  String? cardBank;
  String? expiringMonth;
  String? expiringYear;
  String? cardNumber;
  String? cvv;

  CardDetailsModal({
    this.cardFirstFourDigit,
    this.cardLastFourDigit,
    this.authorizationCode,
    this.cardType,
    this.cardBrand,
    this.cardBank,
    this.expiringMonth,
    this.expiringYear,
    this.cardNumber,
    this.cvv,
  });

  // now create converter

  factory CardDetailsModal.fromJson(Map<String,dynamic> responseData){
    return CardDetailsModal(
      cardFirstFourDigit: responseData['bin']??"",
      cardLastFourDigit: responseData['last4']??"",
      authorizationCode : responseData['authorization_code']??"",
      cardType: responseData['card_type']??"",
      cardBrand: responseData['brand']??"",
      cardBank: responseData['bank']??"",
      expiringMonth: responseData['exp_month']??"",
      expiringYear: responseData['exp_year']??"",
      cardNumber: responseData['cardNumber']??"",
      cvv: responseData['cvv']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cardFirstFourDigit": cardFirstFourDigit,
      "cardLastFourDigit": cardLastFourDigit,
      "authorizationCode": authorizationCode,
      "cardType": cardType,
      "cardBrand": cardBrand,
      "cardBank": cardBank,
      "expiringMonth": expiringMonth,
      "expiringYear": expiringYear,
      "cardNumber": cardNumber,
      "cvv": cvv,
    };
  }
}