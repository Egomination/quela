import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StaffStates extends Equatable {
  StaffStates([List props = const []]) : super(props);
}

class StaffUninitialized extends StaffStates {
  @override
  String toString() => 'StaffUninitialized';
}

class StaffLoading extends StaffStates {
  @override
  String toString() => 'StaffLoading';
}

class StaffLoaded extends StaffStates {
  @override
  String toString() => 'StaffLoaded';
}

class StaffError extends StaffStates {
  final String error;

  StaffError({@required this.error}) : super([error]);

  @override
  String toString() => 'StaffError{ error: $error }';
}
