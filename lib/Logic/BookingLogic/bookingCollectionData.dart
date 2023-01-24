import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/bookingModel.dart';

class BookingCollections{
  static List<CustomerBookingDetailsModel>bookingDetails = <CustomerBookingDetailsModel>[];

  customerBookingDetailsJson({
    sourceLatitude,
    sourceLogitude,
    destinationLatitude,
    destinationLogitude,
    item,
    receiver,
    sender,
    driverInfo,
    amount,
    isPaymentSuccessful,
    sourceAddress,
    destinationAddress,
    totalAmount,
    companyDetails,
    distance,
    timeTaken,
    country,
    state,
    methodOfPayment,
}) async {
    var userId = await UserPreferences().getUserId();


    CustomerBookingDetailsModel bookingJson = CustomerBookingDetailsModel(
      userId: userId,
      sourceLogitude: sourceLogitude,
      sourceLatitude: sourceLatitude,
      destinationLatitude: destinationLatitude,
      destinationLogitude: destinationLogitude,
      item: item,
      receiver: receiver,
      sender: sender,
      driverInfo: driverInfo,
      amount: amount,
      isPaymentSuccessful: isPaymentSuccessful,
      sourceAddress: sourceAddress,
      destinationAddress: destinationAddress,
      totalAmount: totalAmount,
      companyDetails: companyDetails,
      distance: distance,
      timeTaken: timeTaken,
      country: country,
      state: state,
      methodOfPayment: methodOfPayment
    ) ;

    if(bookingDetails.isNotEmpty){
    for(var element in bookingDetails ){
      element.userId = userId;
      element.sourceLatitude=sourceLatitude??element.sourceLatitude;
      element.sourceLogitude= sourceLogitude?? element.sourceLogitude;
      element.destinationLatitude= destinationLatitude??element.destinationLatitude;
      element.destinationLogitude= destinationLogitude??element.destinationLogitude;
      element.item=item??element.item;
      element.receiver=receiver??element.receiver;
      element.sender=sender??element.sender;
      element.driverInfo=driverInfo??element.driverInfo;
      element.amount=amount??element.amount;
      element.isPaymentSuccessful=isPaymentSuccessful??element.isPaymentSuccessful;
      element.sourceAddress=sourceAddress??element.sourceAddress;
      element.destinationAddress=destinationAddress??element.destinationAddress;
      element.totalAmount=totalAmount??element.totalAmount;
      element.companyDetails=companyDetails??element.companyDetails;
      element.distance=distance??element.distance;
      element.timeTaken=timeTaken??element.timeTaken;
      element.country=country??element.country;
      element.state=state??element.state;
      element.methodOfPayment=methodOfPayment??element.methodOfPayment;
    }

  }else{
      bookingDetails.add(bookingJson);
    }
  }
}