import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/notificationModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Providers/userProvider.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/authServices.dart';
import 'package:sure_move/Services/fundsServices.dart';
import 'package:sure_move/Services/userServices.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(UserInitial()) {
    // handle User init
    on<UserUpdateProfileRequested>(_onUserUpdateProfileRequested);
    on<UserUploadFileRequested>(_onUserUploadFileRequested);
    on<UserDeleteFileRequested>(_onUserDeleteFileRequested);
    on<UserTransferCashRequested>(_onUserTransferCashRequested);
    on<WriteToSupportRequested>(_onWriteToSupportRequested);
    on<AccountStatusRequested>(_onGetAccountStatus);
    on<UserVerifyEmailCode>(_onAuthVerifyEmailCode);

  }
dynamic amount;
  


  Future<FutureOr<void>> _onUserUpdateProfileRequested(UserUpdateProfileRequested event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      var response = await UserServices.updateProfile(
        updateUsername: event.updateUsername,
        updateEmail: event.updateEmail,
        profileImageUrl: event.profileImageUrl,
        firstName: event.firstName,
        lastName: event.lastName,
        gender: event.gender
      );
      if(response is Success){
        NewUser authUser = NewUser.fromJson(response.data!["data"]);
        emit(UserDataSuccess([authUser],[response.data!["message"]]));

      }
      if(response is Failure){
        emit(UserDenied([response.errorResponse.toString()]));
      }

    }catch(e){
      emit(UserDenied([e.toString()]));
    }}

    Future<FutureOr<void>> _onUserUploadFileRequested(UserUploadFileRequested event, Emitter<UserState> emit) async {
      try {

        emit(UserLoading());
        var response = await UserServices.uploadImage(file: event.file);
        if(response is Success){
          emit(FileUploadedSuccess([response.data!["message"].toString(), response.data!["data"]["image"]]));
        }
        if(response is Failure){

          emit(UserDenied([response.errorResponse.toString()]));
        }

      }catch(e){

        emit(UserDenied([e.toString()]));
      }
  }

  Future<FutureOr<void>> _onUserDeleteFileRequested(UserDeleteFileRequested event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      var response = await UserServices.deleteImage(fileName: event.fileName);
      if(response is Success){
        emit(UserSuccess());
      }
      if(response is Failure){

        emit(UserImageDeletedDenied([response.errorResponse.toString()]));
      }

    }catch(e){

      emit(UserImageDeletedDenied([e.toString()]));
    }
  }


  pickFile() async {
    // Pick an image
    try{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowCompression: true,type: FileType.image);

    if (result != null) {
     File pickedFile = File(result.files.single.path!);
     return pickedFile;
    } else {
      // User canceled the picker
      return null;
    }
  }catch(e){
      return null;
    }
  }

  Future<FutureOr<void>> onSavingNotification() async {
    try {

      var response = await UserServices.getAllNotification();
      if(response is Success){
        final List<dynamic> responseData = response.data!["data"];
        final notification = responseData.map((json) => NotificationModel.fromJson(json)).toList();

        await UserPreferences().saveNotification(notification, "Notification");

      }
      if(response is Failure){
      throw response.errorResponse.toString();
      }

    }catch(e){
      throw e.toString();
    }
  }

  onGettingNotification() async {
    var response = await UserPreferences().getMessages( "Notification");
    final notification = response.map((json) => NotificationModel.fromJson(json)).toList();
    return notification;

  }

  Future<FutureOr<void>> _onUserTransferCashRequested(UserTransferCashRequested event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      var response = await FundsServices.transferCash(event.amount,event.email);
      if(response is Success){
        emit(UserDataSuccess([],[response.data!["message"].toString()]));
      }
      if(response is Failure){

        emit(UserDenied([response.errorResponse.toString()]));
      }

    }catch(e){

      emit(UserDenied([e.toString()]));
    }
  }

  Future<FutureOr<void>> _onWriteToSupportRequested(WriteToSupportRequested event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      var response = await UserServices.writeToSupport(event.header,event.message);
      if(response is Success){
        emit(UserSuccess());
      }
      if(response is Failure){
        emit(UserDenied([response.errorResponse.toString()]));
      }

    }catch(e){
      emit(UserDenied([e.toString()]));
    }
}

  Future<FutureOr<void>> _onGetAccountStatus(AccountStatusRequested event,Emitter<UserState> emit ) async {
      try {
        emit(UserLoading());
        var response = await UserServices.accountStatus(event.type);
        if(response is Success){
          NewUser authUser = NewUser.fromJson(response.data!["data"]);

          emit(UserDataSuccess([authUser], [response.message.toString()]));
          return response.message;
        }
        if(response is Failure){
           emit(UserDenied([response.errorResponse.toString()]));
         return response.errorResponse.toString();
        }

      }catch(e){
        emit(UserDenied([e.toString()]));
        return e.toString();
      }
    }

    onAccountStatus(type,context) async {
      try {

        var response = await UserServices.accountStatus(type);
        if(response is Success){
          NewUser authUser = NewUser.fromJson(response.data!["data"]);
          Provider.of<UserProvider>(context,listen: false).setUser(authUser);

          return response.message;
        }
        if(response is Failure){

          return response.errorResponse.toString();
        }

      }catch(e){
        return e.toString();
      }
    }

  Future<FutureOr<void>> _onAuthVerifyEmailCode(UserVerifyEmailCode event, Emitter<UserState> emit) async {
    try{
      emit(UserLoading());
      //get the users details from the storage
      var response = await AuthServices.verifyEmailVerificationCode();
      if (response is Success) {
        NewUser authUser = NewUser.fromJson(response.data!["data"]);

        emit( UserVerifySuccess(authUser,response.data!["message"].toString()));
      }
      if(response is Failure){
        emit(UserDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      emit( UserDenied([e.toString()]));
    }
  }
}