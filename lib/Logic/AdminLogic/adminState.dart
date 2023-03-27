import 'package:equatable/equatable.dart';
import 'package:sure_move/Models/userModel.dart';

abstract class AdminState extends Equatable {
  const AdminState([List props = const []]): super();
}

class AdminInitial extends AdminState {
  @override
  List<Object> get props =>[];
}


class AdminGeneral extends AdminState {
  @override
  List<Object> get props =>[];
}

class AdminLoading extends AdminState {
  @override
  List<Object> get props =>[];
}

class AdminSuccess extends AdminState {
  final List<dynamic>? success;
  final String? message;
   const AdminSuccess(this.success, this.message);

  @override
  List<Object> get props => [];
}

class AdminDenied extends AdminState {
  final List<String> errors;
  const AdminDenied(this.errors);

  @override
  List<Object> get props => [errors];
}
