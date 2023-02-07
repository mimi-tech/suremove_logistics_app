import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/userServices.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(): super(UserInitial()) {
    // handle User init
    on<UserUpdateProfileRequested>(_onUserUpdateProfileRequested);
    on<UserUploadFileRequested>(_onUserUploadFileRequested);
    on<UserDeleteFileRequested>(_onUserDeleteFileRequested);

  }

  


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
          print("ffff${response.errorResponse}");

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
        print("eee${response.errorResponse}");
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

}