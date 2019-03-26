import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/staff/event.dart';
import 'package:quela/bloc/staff/state.dart';

class StaffsBloc extends Bloc<StaffEvents, StaffStates> {
  final Future<String> userId = new Auth().getUser();

  @override
  StaffStates get initialState => StaffUninitialized();

  @override
  Stream<StaffStates> mapEventToState(
    StaffStates currentState,
    StaffEvents event,
  ) async* {
    if (event is CreatePatient) {}
  }
}
