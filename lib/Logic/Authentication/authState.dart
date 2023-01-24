import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState([List props = const []]): super();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props =>[];
}


class AuthGeneral extends AuthState {
  @override
  List<Object> get props =>[];
}

class AuthAuthenticated extends AuthState {
  @override
  List<Object> get props =>[];
}

class AuthNotAuthenticated extends AuthState {
  @override
  List<Object> get props =>[];
}


class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}


class AuthSuccess extends AuthState {
  // final List<String> success;
  // const AuthSuccess(this.success);

  @override
  List<Object> get props => [];
}


class AuthDenied extends AuthState {
  final List<String> errors;
  const AuthDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class AuthDeniedForever extends AuthState {
  final List<String> errors;
  const AuthDeniedForever(this.errors);

  @override
  List<Object> get props => [errors];
}

class AuthCodeSent extends AuthState {
  final List<String> message;
  const AuthCodeSent(this.message);

  @override
  List<Object> get props => [message];
}

class AuthGetUser extends AuthState {


  @override
  List<Object> get props => [];
}