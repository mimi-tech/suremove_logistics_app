import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/BookingLogic/bookingCollectionData.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/authServices.dart';
import 'package:url_launcher/url_launcher.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(): super(AuthInitial()) {
    // handle auth init
    on<AuthInit>(_onAuthenticationInit);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthLoginRequested>(_onAuthenticationLoginRequested);
    on<SendOtpRequested>(_sendOtpRequested);
    on<VerifyOtpRequested>(_verifyOtpRequested);
    //on<Authenticated>(_onAuthenticated);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthUpdatePasswordRequested>(_onAuthUpdatePasswordRequested);
    on<AuthSendEmailVerificationCode>(_onAuthSendEmailVerificationCode);
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Duration duration = const Duration(seconds: 1);

  getLocation(Emitter<AuthState> emit) async{
    try{
    bool serviceEnabled;
    //LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
       emit(const AuthDenied(["Location services in your device are disabled. Please turn it on."]));
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(AuthAuthenticated());

      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(const AuthDeniedForever([]));
      return;
    }
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // this is all you need
    var first = placemarks.first;
    String? subLocality = first.subLocality;
    String? locality = first.locality;//Owerri
    String? administrativeArea = first.administrativeArea;//Imo
    String? country = first.country;//country
    String? hdh= first.subThoroughfare;//no
    String? ns = first.thoroughfare;//egbu Road
    String address = "$subLocality $ns $hdh $locality $administrativeArea state, $country";

    BookingCollections().customerBookingDetailsJson(
      sourceLatitude: position.latitude,
      sourceLogitude: position.longitude,
      sourceAddress: address,
      country: first.country,
      state: first.administrativeArea,
    );

  }catch(e){
      print("This is from geolocation $e");
      emit(AuthAuthenticated());
    }
  }

  Future<FutureOr<void>> _onAuthenticationInit(AuthInit event, Emitter<AuthState> emit) async {

    var token = await UserPreferences().getToken();
    if(token != ""){
      await getLocation(emit);
      emit(AuthAuthenticated());
    }else{
      await getLocation(emit);
      emit(AuthNotAuthenticated());
    }

  }


  Future<FutureOr<void>> _onAuthenticationLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {

      UserPreferences().removeUser();
      await Future.delayed(duration);

      emit(AuthNotAuthenticated());

    }catch(error){

      emit( AuthNotAuthenticated());
    }
  }

  Future<FutureOr<void>> _onAuthenticationLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    try{
      emit(AuthLoading());
      //get the users details from the storage
      var response = await AuthServices.loginUser(event.email,event.password);
      if (response is Success) {
        NewUser authUser = NewUser.fromJson(response.data!["data"]);
        UserPreferences().saveUser(authUser);
         UserPreferences().saveToken(response.data!["token"]);
        UserPreferences().saveAuthId(response.data!["data"]['id']);

       emit(AuthSuccess());
        emit(AuthGetUser());
      }
      if(response is Failure){
       emit(AuthDenied([response.errorResponse.toString()]));

      }
    } catch (e) {
      emit(const AuthDenied([kError]));
    }
  }

  Future<FutureOr<void>> _sendOtpRequested(SendOtpRequested event, Emitter<AuthState> emit,) async {
    try{
      emit(AuthLoading());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          emit(AuthGeneral());

        },
        verificationFailed: (FirebaseAuthException e) { AuthDenied([e.message!.toString()]);},
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSent([verificationId]));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }on  FirebaseAuthException catch (e) {
      emit( AuthDenied([e.message.toString()]));
    }
  }

  Future<FutureOr<void>> _verifyOtpRequested(VerifyOtpRequested event, Emitter<AuthState> emit) async {
    try{
      emit(AuthLoading());
// Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otp);
      await auth.signInWithCredential(credential);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit( AuthDenied([e.message.toString()]));
    }
  }

  Future<FutureOr<void>> _onAuthRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    try{
      emit(AuthLoading());
      //get the users details from the storage
      var response = await AuthServices.registerUser(
          emailAddress: event.email,
          password: event.password,
          phoneNumber: event.phoneNumber,
          profileImageUrl: event.profileImageUrl,
          firstName: event.firstName,
          lastName: event.lastName,
         gender: event.gender,
         referralId: event.referralId,
         whoAreYou: event.whoAreYou,
        txnPin: event.txnPin
      );
      if (response is Success) {
        //get the users details from the storage
        var response = await AuthServices.loginUser(event.email,event.password);
        if (response is Success) {
          NewUser authUser = NewUser.fromJson(response.data!["data"]);
          UserPreferences().saveUser(authUser);
          UserPreferences().saveToken(response.data!["token"]);
          UserPreferences().saveAuthId(response.data!["data"]['id']);
          emit(AuthSuccess());
        }
        if(response is Failure){
          emit(AuthDenied([response.errorResponse.toString()]));
        }
      }
      if(response is Failure){
        emit(AuthDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(const AuthDenied([kError]));
    }
  }


  Future<FutureOr<void>> _onAuthSendEmailVerificationCode(AuthSendEmailVerificationCode event, Emitter<AuthState> emit) async {
    try{
      emit(AuthLoading());
      //get the users details from the storage
      var response = await AuthServices.sendEmailVerificationCode(event.email);
      if (response is Success) {
        emit(AuthSuccess());
      }
      if(response is Failure){
        emit(AuthDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(const AuthDenied([kError]));
    }
  }

  Future<FutureOr<void>> _onAuthUpdatePasswordRequested(AuthUpdatePasswordRequested event, Emitter<AuthState> emit) async {
    try{
      emit(AuthLoading());
      //get the users details from the storage
      var response = await AuthServices.updatePassword(event.password);
      if (response is Success) {
        emit(AuthSuccess());
      }
      if(response is Failure){
        emit(AuthDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit(const AuthDenied([kError]));
    }
  }

  dynamic launchTel(phoneNumber) async {
    try
    {
      Uri email = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      await launchUrl(email);
    }
    catch(e) {
      throw(e.toString());
    }
  }

}