import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class AuthInit extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested(this.email, this.password, this.phoneNumber);
  final String email;
  final String password;
  final String phoneNumber;

  @override
  List<Object> get props => [email, password,phoneNumber];
}


class AuthLogoutRequested extends AuthEvent {}

class Authenticated extends AuthEvent {
  const Authenticated(this.token);
  final String token;
  //final User user;

  @override
  List<Object> get props => [token];
}

class SendOtpRequested extends AuthEvent {
  const SendOtpRequested(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpRequested extends AuthEvent {
  const VerifyOtpRequested(this.otp, this.verificationId);
  final String otp;
  final String verificationId;

  @override
  List<Object> get props => [otp,verificationId];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested(
      this.email,
      this.password,
      this.phoneNumber,
      this.username,
      this.profileImageUrl,
      this.firstName,
      this.lastName,
      this.gender,
      this.referralId,
      this.whoAreYou,
      this.txnPin
      );
  final String email;
  final String password;
  final String phoneNumber;
  final String username;
  final String profileImageUrl;
  final String firstName;
  final String lastName;
  final Gender gender;
  final String referralId;
  final AccountType whoAreYou;
  final String txnPin;

  @override
  List<Object> get props => [
    email,
    password,
    phoneNumber,
    username,
    profileImageUrl,
    firstName,
    lastName,
    gender,
    referralId,
    whoAreYou,
    txnPin
  ];
}

class AuthUpdatePasswordRequested extends AuthEvent {
  const AuthUpdatePasswordRequested(this.password);
  final String password;


  @override
  List<Object> get props => [password];
}

class AuthSendEmailVerificationCode extends AuthEvent {
  const AuthSendEmailVerificationCode(this.email);
  final String email;


  @override
  List<Object> get props => [email];
}