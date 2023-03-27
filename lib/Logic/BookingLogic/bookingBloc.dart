import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/bookingRequirmentsModel.dart';
import 'package:sure_move/Models/cardDetailsModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';

import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/secrets.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Providers/userProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/bookingServices.dart';
import 'package:sure_move/Services/driverService.dart';
import 'package:sure_move/Services/fundsServices.dart';
import 'package:sure_move/Services/userServices.dart';


class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(): super(BookingInitial()) {
    // handle auth init

    on<PaymentMethodType>(onGettingUserPaymentMethod);
    on<CalculateCostRequested>(_onGettingBookingCost);
    on<MatchADriverRequested>(_onGettingMatchedDriver);
    on<UpdateBookingRequested>(_onUpdateBookingRequested);
    on<CustomerConfirmBookingRequested>(_onCustomerConfirmBooking);
    on<CustomerTransactionRequested>(_onCardPaymentMethod);
    on<UserAddCardRequested>(_onAddCard);
    on<UserRemoveCardRequested>(_onRemoveCard);
    on<CustomerGetABookingRequested>(_onGetABookingStream);

  }
List<DriverModel> matchedDrivers = <DriverModel>[];
  bool check = true;
  int count = 0;
  onBookingRequirementsRequested(context) async {

      //get the users details from the storage
      var response = await BookingServices.getBookingRequirements();
      if (response is Success) {

        BookingRequirementsModel requirements = BookingRequirementsModel.fromJson(response.data!["data"][0]);
        Provider.of<BookingProvider>(context,listen: false).setRequirements(requirements);

      }
      if(response is Failure){
        throw(response.errorResponse.toString());
      }

  }


  onGettingUserPaymentMethod(PaymentMethodType event, Emitter<BookingState> emit) async {
    try{
      var userPaymentType = await UserPreferences().getPaymentType();

      emit(UserPaymentType([userPaymentType]));

    }catch(e){
      emit(BookingDenied([e.toString()]));
    }
  }

  onSettingUserPaymentMethod(paymentType) async {
    try{
       UserPreferences().savePaymentType(paymentType);
    }catch(e){
      emit(BookingDenied([e.toString()]));
    }
  }

  _onGettingBookingCost(CalculateCostRequested event, Emitter<BookingState> emit) async {
    try{
      emit(UserLoading());
      double distanceInMeters = Geolocator.distanceBetween(
          BookingCollections.bookingDetails[0].sourceLatitude,
          BookingCollections.bookingDetails[0].sourceLogitude,
          BookingCollections.bookingDetails[0].destinationLatitude,
          BookingCollections.bookingDetails[0].destinationLatitude,
          );
         var metersToKg = distanceInMeters / 1000;
      var response = await BookingServices.bookingCost(event.itemNumber,event.itemSize,metersToKg.round());
      if (response is Success) {
        var data = response.data!["data"];
        BookingCollections().customerBookingDetailsJson(
          amount: data,
          totalAmount:  data,
          distance: metersToKg,
            timeTaken: "12"
        );
        //check if user has a payment method
        var result = await UserPreferences().getPaymentType();
        if(result == "" || result == null){
          emit(BookingNoPayment());
        }else{
          emit(BookingCostCalculated());
        }

      }
      if(response is Failure){
        emit(BookingDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(BookingDenied([e.toString()]));
    }
  }
  _onRemoveCard(UserRemoveCardRequested event, Emitter<BookingState> emit)  {
    try{
       UserPreferences().removeCard();
       emit(CardRemoved());
    }catch(e){
      emit(BookingDenied([e.toString()]));
    }
  }

  _onAddCard(UserAddCardRequested event, Emitter<BookingState> emit) async {
    var cardData = {
      "cardNumber":event.cardNumber,
      "exp_month":event.exp_month,
      "exp_year":event.exp_year,
      "cvv":event.cvv,
      "bin":event.bin,
      "last4":event.last4,
      "formattedCardNumber":event.formattedCardNumber
    };
    CardDetailsModal cardDetailsModal = CardDetailsModal.fromJson(cardData);

    //Save the user card details with shared pref
    await UserPreferences().cardDetails(cardDetailsModal);
     emit(AddCard());
  }

  _onCard(email,amount,accessCode,context, Emitter<BookingState> emit) async {
try{
     String newAmount = "${amount}00";
     amount = int.parse(newAmount);
    var cardDetails = await UserPreferences().getCardDetailsNew();
    if(cardDetails.authorizationCode != ""){
      print("authorization is avaliable");
    var response = await FundsServices.chargeAuthorization(email,amount,cardDetails.authorizationCode);
    if (response is Success) {
      return true;
    }

    if (response is Failure) {
      emit(BookingDenied([response.errorResponse.toString()]));
    }
  }else{
      print("No authorization is not avaliable");
      //CHARGE THE CARD
      Charge charge  = Charge();
      charge.card = _getCardFromUI(cardDetails,emit);
      charge
        ..amount = amount! // In base currency
        ..email = email
        ..card = _getCardFromUI(cardDetails,emit)
      // ..reference = _getReference()
        ..accessCode = accessCode

        ..putCustomField('Charged From', kAppTitle);
      chargeCard(charge,context,emit);
    }

  }catch(e){
  emit(BookingDenied([e.toString()]));
  print("bbbbb$e");
  return e;
  }

  }
  chargeCard(Charge charge, BuildContext context, Emitter<BookingState> emit) async {

    final plugin = PaystackPlugin();
    await plugin.initialize(publicKey: testPublicKey);
    final response = await plugin.chargeCard( context, charge: charge);

    //final reference = response.reference;
    print("charge successsful ${response}");
    // Checking if the transaction is successful
    if (response.message == 'Success') {
      //verify Transaction is successful
      print("charge successsful ${response.status}");
      return true;
    }else{
      print("charge not successsful ${response.status}");
      emit(BookingDenied([response.message.toString()]));
    }
  }
  PaymentCard _getCardFromUI(CardDetailsModal cardDetails,Emitter<BookingState> emit) {

    return PaymentCard(
      number: cardDetails.cardNumber,
      cvc: cardDetails.cvv,
      expiryMonth: int.parse(cardDetails.expiringMonth!),
      expiryYear: int.parse(cardDetails.expiringYear!),
    );

  }

  _onCardPaymentMethod(CustomerTransactionRequested event, Emitter<BookingState> emit) async {

    emit(UserLoading());
    var userId = await UserPreferences().getUserId();
    var response = await FundsServices.createCustomer(event.phoneNumber,event.email,event.firstname,event.lastname);
    if (response is Success) {
      print("create customer successful");
      UserPreferences().saveCustomerCode(response.data!['data']['customer_code']);
      UserPreferences().saveCustomerId(response.data!['data']['id']);
     //initialize payment
      var initializeResponse = await FundsServices.initializePayment(event.email,event.amount);
      if(initializeResponse is Success){
        print("initiaze succuss");
        await _onCard(event.email,event.amount, initializeResponse.data!["access_code"],event.context,emit);


        var verifyResponse = await FundsServices.verifySuccessTxn(initializeResponse.data!["data"]["reference"]);
        if(verifyResponse is Success){
          var cardData = verifyResponse.data!['data']['authorization'];
          CardDetailsModal cardDetailsModal = CardDetailsModal.fromJson(cardData);

          //Save the user card details with shared pref
         // UserPreferences().cardDetails(cardDetailsModal);
          UserPreferences().saveCustomerId(verifyResponse.data!['data']['customer']['id']);

          var updateResponse = await FundsServices.updateWallet(event.amount,userId,"fund",event.email);

          if(updateResponse is Success){
            print("update wallet successful");
            await AuthBloc().onGettingUserRequested(event.context);
         emit(PaymentSuccessful());
          }
          if(updateResponse is Failure){
            print("1111${updateResponse.errorResponse}");
            emit(BookingDenied([updateResponse.errorResponse.toString()]));

          }

        }
        if(verifyResponse is Failure){
          print("33333${verifyResponse.errorResponse}");
          emit(BookingDenied([verifyResponse.errorResponse.toString()]));

        }

      }
      if(initializeResponse is Failure){
        print("88888${initializeResponse.errorResponse}");
        emit(BookingDenied([initializeResponse.errorResponse.toString()]));

      }
    }
    if(response is Failure){
      print("99999${response.errorResponse}");
      emit(BookingDenied([response.errorResponse.toString()]));


    }
  }


  _onGettingMatchedDriver(MatchADriverRequested event, Emitter<BookingState> emit) async {
    try{
      emit(UserLoading());
      var response = await BookingServices.matchADriver(event.fullName,event.phoneNumber);
      if (response is Success) {
        final List<dynamic> responseData = response.data!["data"];

        final drivers = responseData.map((json) => DriverModel.fromJson(json)).toList();
       await sendSignalToDriver(event,emit,drivers);

      }
      if(response is Failure){
        if(response.errorResponse == "Driver not found"){
         emit(NotFound());
        }else{

          emit(BookingDenied([response.errorResponse.toString()]));

        }
      }
    } catch (e) {

      emit(BookingDenied([e.toString()]));
    }
  }

  sendSignalToDriver(MatchADriverRequested event, Emitter<BookingState> emit, List<DriverModel> drivers) async {

    print("xxxxx${drivers.length}");
    print("xxxxx111${count}");
    if(drivers.length > count){
    //connect to the first driver
     var driverInfo = {
      "id":drivers[count].driverId,
       "name":drivers[count].firstName + " " + drivers[count].lastName,
       "profilePicture":drivers[count].profileImageUrl,
       "phoneNumber":drivers[count].driverPhoneNumber,
       "gender":drivers[count].gender,
       "rating":drivers[count].rating
     };
     var companyDetails = {
       "id":drivers[count].companyId,
       "name":drivers[count].companyName,
       "owner":drivers[count].owner,
     };
    var createBookingResponse = await BookingServices.createBookingCollection(
        driverInfo,
        companyDetails,
        drivers[count].driverId,
        drivers[count].driverAuthId
    );

    if(createBookingResponse is Success){
      //wait for 5 minutes to check if the driver accepted the booking
      print("waiting");
      await Future.delayed(const Duration(seconds: 10));
      var bookingStatus = await BookingServices.driverConnectionStatus(drivers[count].driverId);
      if (bookingStatus is Success) {
        BookingModel booking = BookingModel.fromJson(createBookingResponse.data!["data"]);

        matchedDrivers.clear();
        matchedDrivers.add(drivers[count]);
        emit(BookingSuccess([booking]));
      }
      if(bookingStatus is Failure){
        print("driver did not answer");
        count = count + 1;
       await sendSignalToDriver(event,emit,drivers);

      }
    }

    if(createBookingResponse is Failure){

      emit(BookingDenied([createBookingResponse.errorResponse.toString()]));
    }
  }else{
      print("Non picked 9999999");
      count = 0;
      emit(NotFound());
    }
  }



  _onUpdateBookingRequested(UpdateBookingRequested event, Emitter<BookingState> emit) async {
    try{
      emit(BookingLoading());
      //calculate cost to update the amount
      double distanceInMeters = Geolocator.distanceBetween(
        BookingCollections.bookingDetails[0].sourceLatitude,
        BookingCollections.bookingDetails[0].sourceLogitude,
        BookingCollections.bookingDetails[0].destinationLatitude,
        BookingCollections.bookingDetails[0].destinationLatitude,
      );
      var metersToKg = distanceInMeters / 1000;
      var response = await BookingServices.bookingCost(event.itemNumber,event.itemSize,metersToKg.round());
      if (response is Success) {
        var data = response.data!["data"];
        var res = await BookingServices.updateBooking(
            event.item,
            event.isLegal,
            event.bookingId,
            data,
            data
        );
        if (res is Success) {

          BookingModel booking = BookingModel.fromJson(res.data!["data"]);
          Provider.of<BookingProvider>(event.context,listen: false).setUser(booking);
          var items = {
            "itemName":event.itemName,
            "itemCount":int.parse(event.itemNumber),
            "itemSize":int.parse(event.itemSize),
            "weight":event.weight
          };
          BookingCollections().customerBookingDetailsJson(
              amount: data,
              totalAmount:  data,
              item: items
          );
          emit(BookingSuccess([]));
        }
        if(res is Failure){
          emit(BookingDenied([res.errorResponse.toString()]));
        }
      }
     
      if(response is Failure){
        emit(BookingDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(BookingDenied([e.toString()]));
    }
  }

  onCancelBookingRequested(String message) async {
    try{
      var response = await BookingServices.cancelBooking(message);
      if (response is Success) {
         return true;
      }
      if(response is Failure){
       return response.errorResponse;
      }
    } catch (e) {
      return e;
    }
  }

  _onCustomerConfirmBooking(CustomerConfirmBookingRequested event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    var response = await BookingServices.customerConfirmBooking(event.bookingId,event.customerAuth);
    if(response is Success){
      emit(BookingSuccess([]));

    }
    if(response is Failure){
      print("Error confirming booking ${response.errorResponse}");
      emit(BookingDenied([response.errorResponse.toString()]));
    }
  }



  _onGetABookingStream(CustomerGetABookingRequested event, Emitter<BookingState> emit ) async {
     emit(BookingLoading());
      var response = await BookingServices.getABooking(event.customerAuthId);

      if(response is Success){
        print("good");
        BookingModel booking = BookingModel.fromJson(response.data!["data"]);
            if(booking.isLegal == true) {

             emit(BookingIsLegal([booking]));
             check = false;
            }else{
              emit(BookingInitial());
            }
        }
if(response is Failure){
  emit(BookingInitial());
  print("Fail $check");
}


    }
  }
