import 'package:equatable/equatable.dart';

abstract class DriverState extends Equatable {
  const DriverState([List props = const []]): super();
}



class DriverLoading extends DriverState {
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


