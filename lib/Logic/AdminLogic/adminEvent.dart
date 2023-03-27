import 'package:equatable/equatable.dart';


abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class AdminInit extends AdminEvent {}

class AdminPromotionalEarningsRequested extends AdminEvent {}

