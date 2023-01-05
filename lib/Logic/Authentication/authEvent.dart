import 'package:equatable/equatable.dart';

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


class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested(this.token);
  final String token;

  @override
  List<Object> get props => [token];
}

class Authenticated extends AuthEvent {
  const Authenticated(this.token);
  final String token;
  //final User user;

  @override
  List<Object> get props => [token];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested(this.email, this.password, this.device);
  final String email;
  final String password;
  final String device;

  @override
  List<Object> get props => [email, password, device];
}

class AuthUpdatePasswordRequested extends AuthEvent {
  const AuthUpdatePasswordRequested(this.password);
  final String password;


  @override
  List<Object> get props => [password];
}