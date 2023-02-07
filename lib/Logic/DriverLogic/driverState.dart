import 'package:equatable/equatable.dart';
import 'package:sure_move/Models/bookingModel.dart';

abstract class DriverState extends Equatable {
  const DriverState([List props = const []]): super();
}



class DriverLoading extends DriverState {
  @override
  List<Object> get props => [];
}

class IsBookingLegalLoading extends DriverState {
  @override
  List<Object> get props => [];
}
class DriverInitial extends DriverState {
  @override
  List<Object> get props =>[];
}

class DriverSuccess extends DriverState {
  // final List<String> success;
  // const AuthSuccess(this.success);

  @override
  List<Object> get props => [];
}

class DriverIsLegal extends DriverState {

  @override
  List<Object> get props => [];
}

class DriverRejectedBooking extends DriverState {

  @override
  List<Object> get props => [];
}

class NotFound extends DriverState {
  @override
  List<Object> get props => [];
}

class DriverDenied extends DriverState {
  final List<String> errors;
  const DriverDenied(this.errors);

  @override
  List<Object> get props => [errors];
}


class DeliveryConfirmed extends DriverState {
  final List<BookingModel> data;
  const DeliveryConfirmed(this.data);
  @override
  List<Object> get props => [];
}