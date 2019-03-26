import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:quela/bloc/staff/event.dart';
import 'package:quela/bloc/staff/staff.dart';
import 'package:quela/bloc/staff/state.dart';

class StaffBloc extends Bloc<StaffEvents, StaffStates> {
  final staff = new Staff();

  @override
  StaffStates get initialState => StaffUninitialized();

  @override
  Stream<StaffStates> mapEventToState(
    StaffStates currentState,
    StaffEvents event,
  ) async* {
    if (event is CreatePatientEvent) {
      yield StaffFetching();
      try {
        await staff.createPatient(
          email: event.email,
          password: event.password,
          name: event.name,
          surname: event.surname,
          tc: event.tc,
          profilePic: event.profilePic,
        );
        yield StaffFetched();
      } catch (err) {
        yield StaffError(error: err.toString());
      }
    }
  }
}
