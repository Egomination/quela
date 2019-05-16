import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:quela/bloc/blocs.dart';

class MockAuth extends Mock implements Auth {}

void main() {
  AuthBloc authBloc;
  MockAuth auth;

  setUp(() {
    auth = MockAuth();
    authBloc = AuthBloc(auth: auth);
  });

  test('initial state is correct', () {
    expect(authBloc.initialState, Unauthenticated());
  });

  test('dispose does not emit new states', () {
    expectLater(
      authBloc.state,
      emitsInOrder([]),
    );
    authBloc.dispose();
  });

  group('AppStarted', () {
    test('emits unauthenticated when there is no token', () {
      when(auth.hasToken()).thenAnswer((_) => Future.value(false));

      expectLater(authBloc.state, emits(Unauthenticated()));

      authBloc.dispatch(AppStarted());
    });
  });
  group('LoggedIn', () {
    test('logins in order when the token is provided as patient', () {
      final expectedResponse = [
        Unauthenticated(),
        Loading(),
        PatientAuthenticated(),
      ];

      when(auth.getType()).thenAnswer((_) => Future.value("patient"));

      expectLater(
        authBloc.state,
        emitsInOrder(expectedResponse),
      );

      authBloc.dispatch(LoggedIn(
        token: 'N06b7ifreWfD8zuJRLTmyGFISgA2',
      ));
    });

    test('logins in order when the token is provided as doctor', () {
      final expectedResponse = [
        Unauthenticated(),
        Loading(),
        DoctorAuthenticated(),
      ];

      when(auth.getType()).thenAnswer((_) => Future.value("doctor"));

      expectLater(
        authBloc.state,
        emitsInOrder(expectedResponse),
      );

      authBloc.dispatch(LoggedIn(
        token: 'a3sL8ZCdZ3fVTnsObi7RVC33VYz1',
      ));
    });

    test('logins in order when the token is provided as staff', () {
      final expectedResponse = [
        Unauthenticated(),
        Loading(),
        StaffAuthenticated(),
      ];

      when(auth.getType()).thenAnswer((_) => Future.value("staff"));

      expectLater(
        authBloc.state,
        emitsInOrder(expectedResponse),
      );

      authBloc.dispatch(LoggedIn(
        token: '0HvatwZd9UXMrUSckd6nUfRYZOh1',
      ));
    });
  });
}
