import 'package:equatable/equatable.dart';
import 'package:sure_move/Models/userModel.dart';

abstract class UserState extends Equatable {
  const UserState([List props = const []]): super();
}

class UserInitial extends UserState {
  @override
  List<Object> get props =>[];
}


class UserGeneral extends UserState {
  @override
  List<Object> get props =>[];
}




class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}


class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UserDataSuccess extends UserState {
  final List<NewUser> data;
  final List<String> message;
  const UserDataSuccess(this.data,this.message);

  @override
  List<Object> get props => [data,message];
}

class UserVerifySuccess extends UserState {
  final NewUser? data;
  final String? message;
  const UserVerifySuccess(this.data,this.message);

  @override
  List<Object> get props => [];
}


class FileUploadedSuccess extends UserState {
  final List<dynamic> data;
  const FileUploadedSuccess(this.data);

  @override
  List<Object> get props => [data];
}


class UserDenied extends UserState {
  final List<String> errors;
  const UserDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class UserImageDeletedDenied extends UserState {
  final List<String> errors;
  const UserImageDeletedDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class UserDeniedForever extends UserState {
  final List<String> errors;
  const UserDeniedForever(this.errors);

  @override
  List<Object> get props => [errors];
}

class UserCodeSent extends UserState {
  final List<String> message;
  const UserCodeSent(this.message);

  @override
  List<Object> get props => [message];
}

class UserGetUser extends UserState {


  @override
  List<Object> get props => [];
}