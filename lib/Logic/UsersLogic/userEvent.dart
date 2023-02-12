import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class UserInit extends UserEvent {}

class UserUpdateProfileRequested extends UserEvent {
  const UserUpdateProfileRequested(this.updateEmail, this.updateUsername, this.profileImageUrl, this.firstName,this.lastName,this.gender);
  final String updateEmail;
  final String updateUsername;
  final String profileImageUrl;
  final String firstName;
  final String lastName;
  final String gender;

  @override
  List<Object> get props => [updateEmail, updateUsername,profileImageUrl,firstName,lastName,gender];
}

class UserUploadFileRequested extends UserEvent {
const UserUploadFileRequested(this.file);
final dynamic file;


@override
List<Object> get props => [file];
}


class UserDeleteFileRequested extends UserEvent {
  const UserDeleteFileRequested(this.fileName);
  final dynamic fileName;


  @override
  List<Object> get props => [fileName];
}

class UserTransferCashRequested extends UserEvent {
  const UserTransferCashRequested(this.amount,this.email);
  final int amount;
  final dynamic email;



  @override
  List<Object> get props => [amount,email];
}

class WriteToSupportRequested extends UserEvent {
  const WriteToSupportRequested(this.header, this.message);

  final dynamic header;
  final dynamic message;


  @override
  List<Object> get props => [header, message];
}

class AccountStatusRequested extends UserEvent {
  const AccountStatusRequested(this.type);

  final dynamic type;
  @override
  List<Object> get props => [type];
}
class UserVerifyEmailCode extends UserEvent {}

