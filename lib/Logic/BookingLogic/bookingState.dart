import 'package:equatable/equatable.dart';
import 'package:sure_move/Models/bookingModel.dart';
import 'package:sure_move/Models/userModel.dart';

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
  final List<BookingModel> booking;

  const BookingSuccess(this.booking);
  @override
  List<Object> get props => [];
}

class BookingCostCalculated extends BookingState {

  @override
  List<Object> get props => [];
}

class BookingNoPayment extends BookingState {

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

class PaymentSuccessful extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingDenied extends BookingState {
  final List<String> errors;
  const BookingDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class BookingIsLegal extends BookingState {
  final List<BookingModel> item;
  const BookingIsLegal(this.item);

  @override
  List<Object> get props => [item];
}

class UserPaymentType extends BookingState {
  final List<String> paymentType;
  const UserPaymentType(this.paymentType);

  @override
  List<Object> get props => [paymentType];
}
class CardRemoved extends BookingState {
  @override
  List<Object> get props => [];
}

class AddCard extends BookingState {
  @override
  List<Object> get props => [];
}