import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/auth/bloc.dart';
import 'package:quela/bloc/auth/event.dart';
import 'package:quela/bloc/login/event.dart';
import 'package:quela/bloc/login/state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final Auth auth;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.auth,
    @required this.authBloc,
  })  : assert(auth != null),
        assert(authBloc != null);

  @override
  LoginStates get initialState => BeforeLogin();

  @override
  Stream<LoginStates> mapEventToState(
    LoginEvents event,
  ) async* {
    if (event is ButtonPressed) {
      yield LoginLoading();
      try {
        final token = await auth.signIn(
          email: event.email,
          password: event.password,
        );

        authBloc.dispatch(LoggedIn(token: token));
        yield BeforeLogin();
      } catch (error) {
        yield Failure(error: error.message.toString());
      }
    }
  }
}
