import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class DriversInit extends DriverEvent {}


class DriverUpdateStatusRequested extends DriverEvent {
  const DriverUpdateStatusRequested(this.driverId, this.type);
  final String driverId;
  final String type;

  @override
  List<Object> get props => [driverId, type];
}

class DriverBookingDecisionRequested extends DriverEvent {
  const DriverBookingDecisionRequested(this.driverId, this.customerId, this.type, );
  final String driverId;
  final String type;
  final String customerId;

  @override
  List<Object> get props => [driverId,customerId,type,];
}

class DriverUpdateBookingRequested extends DriverEvent {
  const DriverUpdateBookingRequested(
      this.itemNumber,
      this.itemSize,
      this.itemName,
      this.isLegal,
      this.bookingId,
      this.totalAmount,
      this.amount
      );
  final dynamic itemNumber;
  final dynamic itemSize;
  final dynamic itemName;
  final dynamic isLegal;
  final dynamic bookingId;
  final dynamic totalAmount;
  final dynamic amount;

  @override
  List<Object> get props => [itemNumber, itemSize, itemName, isLegal,bookingId,totalAmount,amount];
}

class DriverConfirmBookingRequested extends DriverEvent {
  const DriverConfirmBookingRequested(this.driverId, this.companyId, );
  final String driverId;
  final String companyId;

  @override
  List<Object> get props => [driverId,companyId,];
}

class DriverGetABookingRequested extends DriverEvent {
  const DriverGetABookingRequested(this.customerAuthId, this.context );
  final String customerAuthId;
  final BuildContext context;

  @override
  List<Object> get props => [customerAuthId,context];
}

class CustomerRatingDriverRequested extends DriverEvent {
  const CustomerRatingDriverRequested(this.message, this.companyID,this.rate,this.customerInfo, this.driverInfo, this.driverId );
  final List message;
  final String companyID;
  final String rate;
  final Object customerInfo;
  final Object driverInfo;
  final String driverId;

  @override
  List<Object> get props => [message,companyID,customerInfo,driverInfo,driverId];
}


