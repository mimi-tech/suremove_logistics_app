import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Services/apiStatus.dart';
import 'package:sure_move/Services/authServices.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(): super(AuthInitial()) {
    // handle auth init
    on<AuthInit>(_onAuthenticationInit);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthLoginRequested>(_onAuthenticationLoginRequested);
    //on<Authenticated>(_onAuthenticated);
    //on<AuthRegisterRequested>(_onAuthRegisterRequested);
    //on<AuthUpdatePasswordRequested>(_onAuthUpdatePasswordRequested);
  }


  Duration duration = const Duration(seconds: 3);
  Future<FutureOr<void>> _onAuthenticationInit(AuthInit event, Emitter<AuthState> emit) async {

    var result = await UserPreferences().getUser();
    if(result.token != ""){
      await Future.delayed(duration);
      emit(AuthAuthenticated());
    }else{
      await Future.delayed(duration);
      emit(AuthNotAuthenticated());
    }

  }

  Future<void> getCurrentUser() async {
    var result = await UserPreferences().getUser();
    if(result.token != ""){
      await Future.delayed(duration);
      emit(AuthAuthenticated());
    }else{
      await Future.delayed(duration);
      emit(AuthNotAuthenticated());
    }
  }

  Future<FutureOr<void>> _onAuthenticationLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {

      //UserPreferences().removeUser();
      await Future.delayed(duration);

      emit(AuthGeneral());

    }catch(error){

      emit(const AuthDenied(["Log out failed"]));
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
       emit(AuthSuccess());
      }
      if(response is Failure){
       emit(AuthDenied([response.errorResponse.toString()]));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(const AuthDenied(["Unknown error"]));
    }
  }}