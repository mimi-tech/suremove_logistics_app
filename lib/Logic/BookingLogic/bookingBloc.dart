import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Logic/BookingLogic/bookingEvent.dart';
import 'package:sure_move/Logic/BookingLogic/bookingState.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Providers/bookingProviders.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Providers/userProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/bookingServices.dart';
import 'package:sure_move/Services/driverService.dart';
import 'package:sure_move/Services/userServices.dart';


class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(): super(UsersInitial()) {
    // handle auth init

    on<PaymentMethodType>(onGettingUserPaymentMethod);
    on<CalculateCostRequested>(_onGettingBookingCost);
    on<MatchADriverRequested>(_onGettingMatchedDriver);
    on<UpdateBookingRequested>(_onUpdateBookingRequested);

  }
List<DriverModel> matchedDrivers = <DriverModel>[];

  onGettingUserRequested(context) async {
    try{
      //get the users details from the storage
      var response = await UserServices.getAUser();
      if (response is Success) {
        NewUser authUser = NewUser.fromJson(response.data!["data"]);
        UserPreferences().saveUser(authUser);
        Provider.of<UserProvider>(context,listen: false).setUser(authUser);
        if(authUser.accountType == AccountType.driver.name){
          var result = await DriverServices.getADriver(authUser.userId);
          if(result is Success){
            DriverModel driver = DriverModel.fromJson(result.data!["data"]);

            Provider.of<DriverProvider>(context,listen: false).setDriver(driver);
          }
          if(result is Failure){
            throw(result.errorResponse.toString());
          }
        }
      }
      if(response is Failure){
      throw(response.errorResponse.toString());
      }
    } catch (e) {
   throw(e.toString());
    }
  }

  onGettingUserPaymentMethod(PaymentMethodType event, Emitter<BookingState> emit) async {
    try{
      var userPaymentType = await UserPreferences().getPaymentType();

      emit(UserPaymentType([userPaymentType]));

    }catch(e){
      emit(UserDenied([e.toString()]));
    }
  }

  onSettingUserPaymentMethod(paymentType) async {
    try{
       UserPreferences().savePaymentType(paymentType);
    }catch(e){
      emit(UserDenied([e.toString()]));
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
            timeTaken: "12mins"
        );
       emit(UserSuccess());
      }
      if(response is Failure){
        emit(UserDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(UserDenied([e.toString()]));
    }
  }

  _onGettingMatchedDriver(MatchADriverRequested event, Emitter<BookingState> emit) async {
    try{
      emit(UserLoading());
      var response = await BookingServices.matchADriver(event.fullName,event.phoneNumber);
      if (response is Success) {
        final List<dynamic> responseData = response.data!["data"];
        final drivers = responseData.map((json) => DriverModel.fromJson(json)).toList();
        //DriverModel drivers = DriverModel.fromJson(response.data!["data"]);


        sendSignalToDriver(event,emit,drivers);

      }
      if(response is Failure){
        if(response.errorResponse == "Driver not found"){
         emit(NotFound());
        }else{
          emit(UserDenied([response.errorResponse.toString()]));
        }
      }
    } catch (e) {
      emit(UserDenied([e.toString()]));
    }
  }

  Future<void> sendSignalToDriver(MatchADriverRequested event, Emitter<BookingState> emit, List<DriverModel> drivers) async {
    int count = 0;
    if(drivers.length >= count){
    //connect to the first driver
     var driverInfo = {
      "id":drivers[count].driverId,
       "name":drivers[count].firstName + drivers[count].lastName,
       "profilePicture":drivers[count].profileImageUrl,
       "phoneNumber":drivers[count].driverPhoneNumber,
       "phoneNumber":drivers[count].driverPhoneNumber,
       "gender":drivers[count].gender,
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
      await Future.delayed(const Duration(minutes: 5));
      var bookingStatus = await BookingServices.driverConnectionStatus(drivers[count].driverId);
      if (bookingStatus is Success) {
        BookingModel booking = BookingModel.fromJson(createBookingResponse.data!["data"]);
        Provider.of<BookingProvider>(event.context,listen: false).setUser(booking);
        matchedDrivers.clear();
        matchedDrivers.add(drivers[count]);
        emit(UserSuccess());
      }
      if(bookingStatus is Failure){
        count = count + 1;
        sendSignalToDriver(event,emit,drivers);

      }
    }

    if(createBookingResponse is Failure){
      emit(UserDenied([createBookingResponse.errorResponse.toString()]));
    }
  }else{
      emit(NotFound());
    }
  }



  _onUpdateBookingRequested(UpdateBookingRequested event, Emitter<BookingState> emit) async {
    try{
      emit(UserLoading());
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
            event.itemSize,
            event.itemNumber,
            event.itemName,
            event.isLegal,
            event.bookingId,
            data,
            data
        );
        if (res is Success) {
          //final List<dynamic> responseData = res.data!["data"];
         // final booking = responseData.map((json) => BookingModel.fromJson(json)).toList();
          BookingModel booking = BookingModel.fromJson(res.data!["data"]);
          Provider.of<BookingProvider>(event.context,listen: false).setUser(booking);
          var items = {
            "itemName":event.itemName,
            "itemCount":int.parse(event.itemNumber),
            "itemSize":int.parse(event.itemSize),
          };
          BookingCollections().customerBookingDetailsJson(
              amount: data,
              totalAmount:  data,
              item: items
          );
          emit(UserSuccess());
        }
        if(res is Failure){
          emit(UserDenied([res.errorResponse.toString()]));
        }
      }
     
      if(response is Failure){
        emit(UserDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(UserDenied([e.toString()]));
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


}