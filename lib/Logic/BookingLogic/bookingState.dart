import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState([List props = const []]): super();
}



class UserLoading extends BookingState {
  @override
  List<Object> get props => [];
}
class UsersInitial extends BookingState {
  @override
  List<Object> get props =>[];
}

class UserSuccess extends BookingState {
  // final List<String> success;
  // const AuthSuccess(this.success);

  @override
  List<Object> get props => [];
}

class NotFound extends BookingState {
  @override
  List<Object> get props => [];
}

class UserDenied extends BookingState {
  final List<String> errors;
  const UserDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class UserPaymentType extends BookingState {
  final List<String> paymentType;
  const UserPaymentType(this.paymentType);

  @override
  List<Object> get props => [paymentType];
}
