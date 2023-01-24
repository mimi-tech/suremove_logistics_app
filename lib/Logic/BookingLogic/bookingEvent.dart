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
  const MatchADriverRequested(this.fullName, this.phoneNumber,this.context);
  final dynamic fullName;
  final dynamic phoneNumber;
  final BuildContext context;

  @override
  List<Object> get props => [fullName, phoneNumber,context];
}

class UpdateBookingRequested extends BookingEvent {
  const UpdateBookingRequested(this.itemNumber, this.itemSize, this.itemName, this.isLegal, this.bookingId, this.context);
  final dynamic itemNumber;
  final dynamic itemSize;
  final dynamic itemName;
  final dynamic isLegal;
  final dynamic bookingId;
  final BuildContext context;

  @override
  List<Object> get props => [itemNumber, itemSize, itemName, isLegal,bookingId, context];
}

class CancelBookingRequested extends BookingEvent {
  const CancelBookingRequested(this.message);
  final dynamic message;

  @override
  List<Object> get props => [message];
}

