import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/auth/event.dart';
import 'package:quela/bloc/auth/state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final Auth auth;

  AuthBloc({@required this.auth}) : assert(auth != null);

  @override
  AuthStates get initialState => Unauthenticated();

  @override
  Stream<AuthStates> mapEventToState(
    AuthStates currentState,
    AuthEvents event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await auth.hasToken();

      if (hasToken) {
        final String type = await auth.getType();
        if (type == "patient") {
          yield PatientAuthenticated();
        } else if (type == "staff") {
          yield StaffAuthenticated();
        } else if (type == "doctor") {
          yield DoctorAuthenticated();
        }
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield Loading();
      await auth.persistToken(event.token);
      final String type = await auth.getType();
      if (type == "patient") {
        yield PatientAuthenticated();
      } else if (type == "staff") {
        yield StaffAuthenticated();
      } else if (type == "doctor") {
        yield DoctorAuthenticated();
      }
    }

    if (event is LoggedOut) {
      yield Loading();
      await auth.deleteToken();
      yield Unauthenticated();
    }
  }
}
