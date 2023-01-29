import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState([List props = const []]): super();
}



class UserLoading extends BookingState {
  @override
  List<Object> get props => [];
}
class BookingInitial extends BookingState {
  @override
  List<Object> get props =>[];
}

class BookingSuccess extends BookingState {

  @override
  List<Object> get props => [];
}

class BookingLoading extends BookingState {

  @override
  List<Object> get props => [];
}

class NotFound extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingDenied extends BookingState {
  final List<String> errors;
  const BookingDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class UserPaymentType extends BookingState {
  final List<String> paymentType;
  const UserPaymentType(this.paymentType);

  @override
  List<Object> get props => [paymentType];
}
