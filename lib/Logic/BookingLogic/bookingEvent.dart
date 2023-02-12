import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class UsersInit extends BookingEvent {}
class GetUser extends BookingEvent {}

class AuthLoginRequested extends BookingEvent {
  const AuthLoginRequested(this.email, this.password, this.phoneNumber);
  final String email;
  final String password;
  final String phoneNumber;

  @override
  List<Object> get props => [email, password,phoneNumber];
}

class PaymentMethodType extends BookingEvent {}

class CalculateCostRequested extends BookingEvent {
  const CalculateCostRequested(this.itemNumber, this.itemSize);
  final dynamic itemNumber;
  final dynamic itemSize;

  @override
  List<Object> get props => [itemNumber, itemSize];
}

class MatchADriverRequested extends BookingEvent {
  const MatchADriverRequested(this.fullName, this.phoneNumber,this.context,this.email, this.firstname, this.lastname, this.amount,);
  final dynamic fullName;
  final dynamic phoneNumber;
  final BuildContext context;
  final String email;
  final String firstname;
  final String lastname;
  final dynamic amount;
  @override
  List<Object> get props => [fullName, phoneNumber,context,email, firstname,lastname,amount];
}

class UpdateBookingRequested extends BookingEvent {
  const UpdateBookingRequested( this.item,this.itemNumber, this.itemSize, this.itemName, this.weight, this.isLegal, this.bookingId, this.context);
  final Object item;
  final dynamic itemNumber;
  final dynamic itemSize;
  final dynamic itemName;
  final dynamic weight;
  final dynamic isLegal;
  final dynamic bookingId;
  final BuildContext context;


  @override
  List<Object> get props => [item,itemNumber, itemSize, itemName,weight, isLegal,bookingId, context];
}

class CancelBookingRequested extends BookingEvent {
  const CancelBookingRequested(this.message);
  final dynamic message;

  @override
  List<Object> get props => [message];
}

class CustomerConfirmBookingRequested extends BookingEvent {
  const CustomerConfirmBookingRequested(this.bookingId, this.customerAuth, );
  final String bookingId;
  final String customerAuth;

  @override
  List<Object> get props => [bookingId,customerAuth,];
}

class CustomerTransactionRequested extends BookingEvent {
  const CustomerTransactionRequested(this.email, this.firstname, this.lastname, this.phoneNumber, this.amount,this.context,this.userAuthId,this.type,this.userEmail);
  final String email;
  final String firstname;
  final String lastname;
  final String phoneNumber;
  final dynamic amount;
  final BuildContext context;
  final dynamic userAuthId;
  final dynamic type;
  final dynamic userEmail;

  @override
  List<Object> get props => [email, firstname,lastname, phoneNumber,amount,context,userAuthId,type,userEmail,];
}


class UserAddCardRequested extends BookingEvent {
  const UserAddCardRequested(this.cardNumber, this.exp_month, this.exp_year, this.cvv, this.bin,this.last4,this.formattedCardNumber);
  final String cardNumber;
  final String exp_month;
  final String exp_year;
  final String cvv;
  final dynamic bin;
  final dynamic last4;
  final dynamic formattedCardNumber;


  @override
  List<Object> get props => [cardNumber, exp_month,exp_year, cvv,bin,last4,formattedCardNumber];
}

class UserRemoveCardRequested extends BookingEvent {
  const UserRemoveCardRequested(this.token,);
  final String token;

  @override
  List<Object> get props => [token];
}

class CustomerGetABookingRequested extends BookingEvent {
  const CustomerGetABookingRequested(this.customerAuthId );
  final String customerAuthId;


  @override
  List<Object> get props => [customerAuthId];
}
