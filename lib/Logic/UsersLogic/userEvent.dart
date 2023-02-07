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
final File file;


@override
List<Object> get props => [file];
}


class UserDeleteFileRequested extends UserEvent {
  const UserDeleteFileRequested(this.fileName);
  final dynamic fileName;


  @override
  List<Object> get props => [fileName];
}


